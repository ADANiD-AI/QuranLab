// SPDX-License-Identifier: MIT
// بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
// "In the name of Allah, the Most Gracious, the Most Merciful"

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title JannahPointsContract
 * @dev Islamic-compliant smart contract for managing spiritual rewards (Jannah Points)
 * @notice This contract follows Islamic principles and is overseen by qualified scholars
 * @author Muhammad Adnan Ul Mustafa (adnanmd76@gmail.com)
 * @custom:islamic-compliance Verified by Islamic Scholar Council
 * @custom:halal-certification Certified Halal Technology
 * @custom:version 1.0
 */
contract JannahPointsContract is AccessControl, ReentrancyGuard, Pausable {
    using Counters for Counters.Counter;

    // ==================== ROLES ====================
    bytes32 public constant HAFIZ_ROLE = keccak256("HAFIZ_ROLE");
    bytes32 public constant SCHOLAR_ROLE = keccak256("SCHOLAR_ROLE");
    bytes32 public constant AI_VERIFIER_ROLE = keccak256("AI_VERIFIER_ROLE");
    bytes32 public constant UBVH_ROLE = keccak256("UBVH_ROLE");
    bytes32 public constant WAQF_MANAGER_ROLE = keccak256("WAQF_MANAGER_ROLE");

    // ==================== STRUCTS ====================
    
    /**
     * @dev Represents a Quranic recitation record
     */
    struct RecitationRecord {
        string recitationId;
        address user;
        uint256 surahNumber;
        uint256 ayahNumber;
        string qiraat;
        uint256 accuracy; // Percentage * 100 (e.g., 9850 = 98.50%)
        uint256 jannahPoints;
        uint256 timestamp;
        bool verified;
        bool humanReviewed;
        address hafizReviewer;
        string ipfsHash;
        string arweaveId;
        RecitationAnalysis analysis;
    }

    /**
     * @dev Detailed analysis of recitation quality
     */
    struct RecitationAnalysis {
        uint256 letterPrecision;
        uint256 makhrajScore;
        uint256 tajweedScore;
        uint256 fluencyScore;
        string[] improvements;
        bool needsHumanReview;
    }

    /**
     * @dev User's spiritual progress and statistics
     */
    struct UserProfile {
        uint256 totalJannahPoints;
        uint256 lifetimeRecitations;
        uint256 perfectRecitations;
        uint256 currentStreak;
        uint256 longestStreak;
        uint256 lastRecitationTime;
        uint256 averageAccuracy;
        bool isActive;
        string preferredQiraat;
        uint256 level; // 1=Beginner, 2=Intermediate, 3=Advanced, 4=Expert
    }

    /**
     * @dev Islamic Waqf (endowment) for charity distribution
     */
    struct WaqfEndowment {
        string name;
        string description;
        address manager;
        uint256 totalDonations;
        uint256 beneficiaryCount;
        bool isActive;
        bool scholarApproved;
        string[] beneficiaryCategories;
    }

    /**
     * @dev Achievement system for spiritual milestones
     */
    struct Achievement {
        string name;
        string description;
        uint256 pointsRequired;
        uint256 pointsReward;
        bool isActive;
        string category; // "recitation", "consistency", "improvement", "charity"
    }

    // ==================== STATE VARIABLES ====================
    
    Counters.Counter private _recitationCounter;
    Counters.Counter private _waqfCounter;
    Counters.Counter private _achievementCounter;

    // Mappings
    mapping(address => UserProfile) public userProfiles;
    mapping(string => RecitationRecord) public recitations;
    mapping(address => string[]) public userRecitations;
    mapping(uint256 => WaqfEndowment) public waqfEndowments;
    mapping(address => mapping(uint256 => bool)) public userAchievements;
    mapping(uint256 => Achievement) public achievements;
    mapping(address => bool) public islamicCompliantUsers;
    mapping(string => bool) public verifiedQiraats;

    // Constants for point calculation
    uint256 public constant BASE_POINTS_PER_AYAH = 10;
    uint256 public constant PERFECT_RECITATION_BONUS = 1000;
    uint256 public constant IMPROVEMENT_MULTIPLIER = 5;
    uint256 public constant CONSISTENCY_BONUS = 250;
    uint256 public constant DAILY_STREAK_BONUS = 50;
    uint256 public constant ACCURACY_THRESHOLD = 9500; // 95.00%

    // Islamic compliance settings
    bool public ribaFreeMode = true;
    bool public halalCertified = true;
    address public scholarCouncil;
    uint256 public scholarApprovalCount;

    // ==================== EVENTS ====================
    
    event RecitationRecorded(
        string indexed recitationId,
        address indexed user,
        uint256 surahNumber,
        uint256 ayahNumber,
        uint256 accuracy,
        uint256 jannahPoints
    );

    event JannahPointsAwarded(
        address indexed user,
        uint256 points,
        string reason,
        uint256 timestamp
    );

    event HafizReviewCompleted(
        string indexed recitationId,
        address indexed hafiz,
        bool approved,
        string feedback
    );

    event WaqfDonation(
        address indexed donor,
        uint256 indexed waqfId,
        uint256 points,
        uint256 spiritualReward
    );

    event AchievementUnlocked(
        address indexed user,
        uint256 indexed achievementId,
        string achievementName,
        uint256 pointsRewarded
    );

    event IslamicComplianceVerified(
        address indexed user,
        address indexed verifier,
        uint256 timestamp
    );

    // ==================== MODIFIERS ====================
    
    modifier onlyIslamicCompliant(address user) {
        require(islamicCompliantUsers[user], "User must be Islamic compliant");
        _;
    }

    modifier onlyVerifiedQiraat(string memory qiraat) {
        require(verifiedQiraats[qiraat], "Qiraat must be verified by scholars");
        _;
    }

    modifier onlyRibaFree() {
        require(ribaFreeMode, "Operation must be Riba-free");
        _;
    }

    // ==================== CONSTRUCTOR ====================
    
    constructor(
        address _scholarCouncil,
        address _ubvhAddress
    ) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(SCHOLAR_ROLE, _scholarCouncil);
        _grantRole(UBVH_ROLE, _ubvhAddress);
        
        scholarCouncil = _scholarCouncil;
        
        // Initialize verified Qiraats
        verifiedQiraats["hafs"] = true;
        verifiedQiraats["warsh"] = true;
        verifiedQiraats["qalun"] = true;
        verifiedQiraats["duri"] = true;
        verifiedQiraats["susi"] = true;
        
        // Create initial achievements
        _createInitialAchievements();
    }

    // ==================== MAIN FUNCTIONS ====================
    
    /**
     * @dev Records a new Quranic recitation with blockchain attestation
     * @param recitationId Unique identifier for the recitation
     * @param user Address of the user who recited
     * @param surahNumber Surah number (1-114)
     * @param ayahNumber Ayah number within the surah
     * @param qiraat Qiraat style used for recitation
     * @param accuracy Accuracy percentage * 100
     * @param ipfsHash IPFS hash for eternal storage
     * @param arweaveId Arweave ID for backup storage
     * @param analysis Detailed recitation analysis
     */
    function recordRecitation(
        string memory recitationId,
        address user,
        uint256 surahNumber,
        uint256 ayahNumber,
        string memory qiraat,
        uint256 accuracy,
        string memory ipfsHash,
        string memory arweaveId,
        RecitationAnalysis memory analysis
    ) 
        external 
        onlyRole(UBVH_ROLE) 
        onlyIslamicCompliant(user)
        onlyVerifiedQiraat(qiraat)
        onlyRibaFree
        nonReentrant
        whenNotPaused
    {
        require(surahNumber >= 1 && surahNumber <= 114, "Invalid surah number");
        require(ayahNumber >= 1, "Invalid ayah number");
        require(accuracy <= 10000, "Accuracy cannot exceed 100%");
        require(bytes(recitationId).length > 0, "Recitation ID required");
        require(bytes(ipfsHash).length > 0, "IPFS hash required for eternal storage");

        // Calculate Jannah points
        uint256 jannahPoints = _calculateJannahPoints(
            user,
            accuracy,
            surahNumber,
            ayahNumber,
            analysis
        );

        // Create recitation record
        RecitationRecord storage record = recitations[recitationId];
        record.recitationId = recitationId;
        record.user = user;
        record.surahNumber = surahNumber;
        record.ayahNumber = ayahNumber;
        record.qiraat = qiraat;
        record.accuracy = accuracy;
        record.jannahPoints = jannahPoints;
        record.timestamp = block.timestamp;
        record.verified = true;
        record.humanReviewed = false;
        record.ipfsHash = ipfsHash;
        record.arweaveId = arweaveId;
        record.analysis = analysis;

        // Update user profile
        _updateUserProfile(user, accuracy, jannahPoints);

        // Add to user's recitation list
        userRecitations[user].push(recitationId);

        // Check for achievements
        _checkAndAwardAchievements(user);

        // Emit events
        emit RecitationRecorded(
            recitationId,
            user,
            surahNumber,
            ayahNumber,
            accuracy,
            jannahPoints
        );

        emit JannahPointsAwarded(
            user,
            jannahPoints,
            "Quranic recitation",
            block.timestamp
        );

        _recitationCounter.increment();
    }

    /**
     * @dev Hafiz reviews and validates a recitation
     * @param recitationId ID of the recitation to review
     * @param approved Whether the recitation is approved
     * @param feedback Hafiz feedback and suggestions
     * @param adjustedAccuracy Hafiz-corrected accuracy score
     */
    function hafizReview(
        string memory recitationId,
        bool approved,
        string memory feedback,
        uint256 adjustedAccuracy
    )
        external
        onlyRole(HAFIZ_ROLE)
        nonReentrant
        whenNotPaused
    {
        RecitationRecord storage record = recitations[recitationId];
        require(record.timestamp > 0, "Recitation not found");
        require(!record.humanReviewed, "Already reviewed by Hafiz");
        require(adjustedAccuracy <= 10000, "Invalid accuracy score");

        record.humanReviewed = true;
        record.hafizReviewer = msg.sender;

        if (approved && adjustedAccuracy != record.accuracy) {
            // Recalculate points with Hafiz correction
            uint256 newPoints = _calculateJannahPoints(
                record.user,
                adjustedAccuracy,
                record.surahNumber,
                record.ayahNumber,
                record.analysis
            );

            // Adjust user's total points
            UserProfile storage profile = userProfiles[record.user];
            profile.totalJannahPoints = profile.totalJannahPoints - record.jannahPoints + newPoints;
            
            record.accuracy = adjustedAccuracy;
            record.jannahPoints = newPoints;
        }

        emit HafizReviewCompleted(recitationId, msg.sender, approved, feedback);
    }

    /**
     * @dev Donate Jannah points to Islamic Waqf (endowment)
     * @param waqfId ID of the Waqf to donate to
     * @param points Number of points to donate
     */
    function donateToWaqf(
        uint256 waqfId,
        uint256 points
    )
        external
        onlyIslamicCompliant(msg.sender)
        onlyRibaFree
        nonReentrant
        whenNotPaused
    {
        require(points > 0, "Donation must be greater than 0");
        require(waqfId < _waqfCounter.current(), "Invalid Waqf ID");
        
        UserProfile storage profile = userProfiles[msg.sender];
        require(profile.totalJannahPoints >= points, "Insufficient Jannah points");
        
        WaqfEndowment storage waqf = waqfEndowments[waqfId];
        require(waqf.isActive, "Waqf is not active");
        require(waqf.scholarApproved, "Waqf must be scholar approved");

        // Deduct points from user
        profile.totalJannahPoints -= points;
        
        // Add to Waqf
        waqf.totalDonations += points;
        
        // Calculate spiritual reward (2x for charity)
        uint256 spiritualReward = points * 2;
        profile.totalJannahPoints += spiritualReward;

        emit WaqfDonation(msg.sender, waqfId, points, spiritualReward);
        emit JannahPointsAwarded(
            msg.sender,
            spiritualReward,
            "Waqf donation reward",
            block.timestamp
        );
    }

    // ==================== INTERNAL FUNCTIONS ====================
    
    /**
     * @dev Calculates Jannah points based on recitation quality
     */
    function _calculateJannahPoints(
        address user,
        uint256 accuracy,
        uint256 surahNumber,
        uint256 ayahNumber,
        RecitationAnalysis memory analysis
    ) internal view returns (uint256) {
        uint256 basePoints = BASE_POINTS_PER_AYAH;
        
        // Accuracy bonus
        uint256 accuracyBonus = (accuracy * basePoints) / 10000;
        
        // Perfect recitation bonus
        uint256 perfectBonus = (accuracy == 10000) ? PERFECT_RECITATION_BONUS : 0;
        
        // Improvement bonus
        UserProfile memory profile = userProfiles[user];
        uint256 improvementBonus = 0;
        if (accuracy > profile.averageAccuracy) {
            improvementBonus = ((accuracy - profile.averageAccuracy) * IMPROVEMENT_MULTIPLIER) / 100;
        }
        
        // Consistency bonus
        uint256 consistencyBonus = 0;
        if (profile.currentStreak >= 7) {
            consistencyBonus = CONSISTENCY_BONUS;
        }
        
        // Daily streak bonus
        uint256 streakBonus = profile.currentStreak * DAILY_STREAK_BONUS;
        
        // Special Surah bonuses
        uint256 surahBonus = _getSurahBonus(surahNumber);
        
        return basePoints + accuracyBonus + perfectBonus + improvementBonus + 
               consistencyBonus + streakBonus + surahBonus;
    }

    /**
     * @dev Updates user profile after recitation
     */
    function _updateUserProfile(
        address user,
        uint256 accuracy,
        uint256 jannahPoints
    ) internal {
        UserProfile storage profile = userProfiles[user];
        
        profile.totalJannahPoints += jannahPoints;
        profile.lifetimeRecitations += 1;
        
        if (accuracy == 10000) {
            profile.perfectRecitations += 1;
        }
        
        // Update streak
        if (block.timestamp - profile.lastRecitationTime <= 86400) { // 24 hours
            profile.currentStreak += 1;
        } else {
            profile.currentStreak = 1;
        }
        
        if (profile.currentStreak > profile.longestStreak) {
            profile.longestStreak = profile.currentStreak;
        }
        
        // Update average accuracy
        profile.averageAccuracy = (
            (profile.averageAccuracy * (profile.lifetimeRecitations - 1)) + accuracy
        ) / profile.lifetimeRecitations;
        
        profile.lastRecitationTime = block.timestamp;
        profile.isActive = true;
        
        // Update level based on total recitations and accuracy
        _updateUserLevel(user);
    }

    /**
     * @dev Updates user level based on progress
     */
    function _updateUserLevel(address user) internal {
        UserProfile storage profile = userProfiles[user];
        
        if (profile.lifetimeRecitations >= 1000 && profile.averageAccuracy >= 9800) {
            profile.level = 4; // Expert
        } else if (profile.lifetimeRecitations >= 500 && profile.averageAccuracy >= 9500) {
            profile.level = 3; // Advanced
        } else if (profile.lifetimeRecitations >= 100 && profile.averageAccuracy >= 9000) {
            profile.level = 2; // Intermediate
        } else {
            profile.level = 1; // Beginner
        }
    }

    /**
     * @dev Gets bonus points for special Surahs
     */
    function _getSurahBonus(uint256 surahNumber) internal pure returns (uint256) {
        if (surahNumber == 1) return 500;  // Al-Fatiha
        if (surahNumber == 2) return 1000; // Al-Baqarah
        if (surahNumber == 36) return 750; // Ya-Sin
        if (surahNumber == 67) return 600; // Al-Mulk
        if (surahNumber == 112) return 400; // Al-Ikhlas
        return 0;
    }

    /**
     * @dev Checks and awards achievements to user
     */
    function _checkAndAwardAchievements(address user) internal {
        UserProfile memory profile = userProfiles[user];
        
        // Check each achievement
        for (uint256 i = 0; i < _achievementCounter.current(); i++) {
            Achievement memory achievement = achievements[i];
            
            if (!userAchievements[user][i] && achievement.isActive) {
                bool earned = false;
                
                if (keccak256(bytes(achievement.category)) == keccak256(bytes("recitation"))) {
                    earned = profile.lifetimeRecitations >= achievement.pointsRequired;
                } else if (keccak256(bytes(achievement.category)) == keccak256(bytes("consistency"))) {
                    earned = profile.longestStreak >= achievement.pointsRequired;
                } else if (keccak256(bytes(achievement.category)) == keccak256(bytes("improvement"))) {
                    earned = profile.averageAccuracy >= achievement.pointsRequired;
                }
                
                if (earned) {
                    userAchievements[user][i] = true;
                    userProfiles[user].totalJannahPoints += achievement.pointsReward;
                    
                    emit AchievementUnlocked(
                        user,
                        i,
                        achievement.name,
                        achievement.pointsReward
                    );
                }
            }
        }
    }

    /**
     * @dev Creates initial achievements
     */
    function _createInitialAchievements() internal {
        // First recitation
        achievements[0] = Achievement({
            name: "First Steps",
            description: "Complete your first recitation",
            pointsRequired: 1,
            pointsReward: 100,
            isActive: true,
            category: "recitation"
        });
        
        // Perfect recitation
        achievements[1] = Achievement({
            name: "Perfect Reciter",
            description: "Achieve 100% accuracy",
            pointsRequired: 10000,
            pointsReward: 1000,
            isActive: true,
            category: "improvement"
        });
        
        // Consistency
        achievements[2] = Achievement({
            name: "Consistent Learner",
            description: "Maintain 30-day streak",
            pointsRequired: 30,
            pointsReward: 2000,
            isActive: true,
            category: "consistency"
        });
        
        _achievementCounter._value = 3;
    }

    // ==================== ADMIN FUNCTIONS ====================
    
    /**
     * @dev Verifies Islamic compliance for a user
     */
    function verifyIslamicCompliance(
        address user
    ) external onlyRole(SCHOLAR_ROLE) {
        islamicCompliantUsers[user] = true;
        emit IslamicComplianceVerified(user, msg.sender, block.timestamp);
    }

    /**
     * @dev Creates a new Waqf endowment
     */
    function createWaqf(
        string memory name,
        string memory description,
        address manager,
        string[] memory beneficiaryCategories
    ) external onlyRole(SCHOLAR_ROLE) returns (uint256) {
        uint256 waqfId = _waqfCounter.current();
        
        waqfEndowments[waqfId] = WaqfEndowment({
            name: name,
            description: description,
            manager: manager,
            totalDonations: 0,
            beneficiaryCount: 0,
            isActive: true,
            scholarApproved: true,
            beneficiaryCategories: beneficiaryCategories
        });
        
        _grantRole(WAQF_MANAGER_ROLE, manager);
        _waqfCounter.increment();
        
        return waqfId;
    }

    /**
     * @dev Emergency pause function
     */
    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    /**
     * @dev Unpause function
     */
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    // ==================== VIEW FUNCTIONS ====================
    
    /**
     * @dev Gets user's complete profile
     */
    function getUserProfile(address user) external view returns (UserProfile memory) {
        return userProfiles[user];
    }

    /**
     * @dev Gets user's recitation history
     */
    function getUserRecitations(address user) external view returns (string[] memory) {
        return userRecitations[user];
    }

    /**
     * @dev Gets recitation details
     */
    function getRecitation(string memory recitationId) external view returns (RecitationRecord memory) {
        return recitations[recitationId];
    }

    /**
     * @dev Gets total number of recitations
     */
    function getTotalRecitations() external view returns (uint256) {
        return _recitationCounter.current();
    }

    /**
     * @dev Gets Waqf details
     */
    function getWaqf(uint256 waqfId) external view returns (WaqfEndowment memory) {
        return waqfEndowments[waqfId];
    }

    /**
     * @dev Checks if user has achieved specific achievement
     */
    function hasAchievement(address user, uint256 achievementId) external view returns (bool) {
        return userAchievements[user][achievementId];
    }

    /**
     * @dev Gets Islamic compliance status
     */
    function getComplianceStatus() external view returns (
        bool ribaFree,
        bool halal,
        address council,
        uint256 approvals
    ) {
        return (ribaFreeMode, halalCertified, scholarCouncil, scholarApprovalCount);
    }
}

/**
 * @title RecitationAttestationContract
 * @dev Companion contract for immutable recitation attestation
 */
contract RecitationAttestationContract {
    struct AttestationRecord {
        string recitationId;
        bytes32 dataHash;
        uint256 timestamp;
        address attester;
        bool verified;
    }

    mapping(string => AttestationRecord) public attestations;
    
    event RecitationAttested(
        string indexed recitationId,
        bytes32 dataHash,
        address attester,
        uint256 timestamp
    );

    function attestRecitation(
        string memory recitationId,
        bytes32 dataHash
    ) external {
        attestations[recitationId] = AttestationRecord({
            recitationId: recitationId,
            dataHash: dataHash,
            timestamp: block.timestamp,
            attester: msg.sender,
            verified: true
        });

        emit RecitationAttested(recitationId, dataHash, msg.sender, block.timestamp);
    }

    function verifyAttestation(
        string memory recitationId,
        bytes32 dataHash
    ) external view returns (bool) {
        AttestationRecord memory record = attestations[recitationId];
        return record.verified && record.dataHash == dataHash;
    }
}

// الحمد لله رب العالمين
// "All praise is due to Allah, Lord of all the worlds"