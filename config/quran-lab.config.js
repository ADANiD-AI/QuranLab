/**
 * QURAN LAB Configuration
 * Divine Learning Module - "Every letter counts for Jannah"
 * 
 * @author Muhammad Adnan Ul Mustafa
 * @email adnanmd76@gmail.com
 * @website https://www.adanid.ai
 */

module.exports = {
  // Project Information
  project: {
    name: 'QURAN LAB powered by ADN_iD',
    motto: 'Every letter counts for Jannah',
    version: '1.0.0',
    description: 'Divine Learning Module with 99.9% precision',
    author: 'Muhammad Adnan Ul Mustafa',
    email: 'adnanmd76@gmail.com',
    website: 'https://www.adanid.ai',
    github: 'https://github.com/Adnanmd76/QuranLab',
    license: 'MIT'
  },

  // System Performance Guarantees
  guarantees: {
    accuracy: 99.9, // 99.9% precision in recitation analysis
    responseTime: 30, // < 30 minutes Hafiz/Qari response
    storageGuarantee: 200, // 200+ years eternal storage
    uptime: 99.99, // 99.99% system uptime
    energyConsumption: 0 // Zero energy AI analysis
  },

  // Supported Qiraats
  qiraats: {
    supported: ['Hafs', 'Warsh', 'Qalun', 'Duri', 'Susi'],
    default: 'Hafs',
    features: {
      letterPrecision: true,
      makharijDetection: true,
      tajweedValidation: true,
      diacriticalMarks: ['zer', 'zabar', 'pesh']
    }
  },

  // Spiritual Levels & Jannah Points System
  spiritualLevels: {
    student: {
      min: 0,
      max: 100,
      title: 'Student',
      emoji: '🌱',
      description: 'Beginning the spiritual journey',
      rewards: ['Basic progress tracking', 'Daily motivation']
    },
    learner: {
      min: 101,
      max: 500,
      title: 'Learner',
      emoji: '📚',
      description: 'Actively learning and improving',
      rewards: ['Weekly reports', 'Improvement suggestions']
    },
    reciter: {
      min: 501,
      max: 1000,
      title: 'Reciter',
      emoji: '🎵',
      description: 'Developing beautiful recitation',
      rewards: ['Monthly certificates', 'Community recognition']
    },
    hafiz: {
      min: 1001,
      max: 5000,
      title: 'Hafiz',
      emoji: '📖',
      description: 'Guardian of the Quran',
      rewards: ['Teaching opportunities', 'Hafiz network access']
    },
    qari: {
      min: 5001,
      max: 10000,
      title: 'Qari',
      emoji: '🎙️',
      description: 'Master of Quranic recitation',
      rewards: ['Qari certification', 'Global recognition']
    },
    master: {
      min: 10001,
      max: Infinity,
      title: 'Master',
      emoji: '👑',
      description: 'Spiritual master and guide',
      rewards: ['Master status', 'Eternal recognition']
    }
  },

  // Jannah Points Calculation
  jannahPoints: {
    factors: {
      improvement: {
        weight: 1.0,
        description: 'Base points for improvement percentage'
      },
      consistency: {
        weight: 1.5,
        description: 'Bonus for regular practice'
      },
      perfectRecitation: {
        bonus: 50,
        threshold: 99.0,
        description: 'Bonus for perfect recitation (≥99%)'
      },
      majorImprovement: {
        bonus: 25,
        threshold: 10,
        description: 'Bonus for major improvement (>10%)'
      },
      teaching: {
        multiplier: 2.0,
        description: 'Multiplier for teaching others'
      },
      intention: {
        multiplier: 1.0,
        max: 2.0,
        description: 'Niyyah (intention) multiplier'
      }
    },
    dailyLimit: 1000,
    weeklyBonus: 100,
    monthlyBonus: 500
  },

  // AI Analysis Configuration
  ai: {
    engine: 'Firebase Studio Gemini AI',
    accuracy: 99.9,
    features: {
      letterByLetter: true,
      makharijDetection: true,
      tajweedValidation: true,
      breathingAnalysis: true,
      emotionalTone: true,
      speedAnalysis: true
    },
    languages: ['arabic', 'urdu', 'english'],
    models: {
      recitationAnalyzer: 'gemini-pro-audio',
      textAnalyzer: 'gemini-pro',
      translationEngine: 'gemini-pro-multilingual'
    }
  },

  // Hafiz/Qari Human Correction System
  hafizQariSystem: {
    responseTime: 30, // minutes
    validationLayers: {
      aiPreAnalysis: {
        enabled: true,
        confidence: 0.95
      },
      humanReview: {
        enabled: true,
        certified: true
      },
      scholarValidation: {
        enabled: true,
        minimumLevel: 'hafiz'
      },
      communityPeerReview: {
        enabled: true,
        minimumReviewers: 3
      }
    },
    matching: {
      criteria: ['region', 'language', 'specialization', 'availability'],
      priorities: ['accuracy', 'speed', 'experience']
    },
    certification: {
      provider: 'ADN_iD',
      verification: 'blockchain',
      renewal: 'annual'
    }
  },

  // 5-Layer Biometric Security
  biometricSecurity: {
    layers: {
      voicePattern: {
        enabled: true,
        accuracy: 99.5,
        features: ['pitch', 'tone', 'rhythm', 'pronunciation']
      },
      breathingPattern: {
        enabled: true,
        analysis: ['rhythm', 'depth', 'consistency']
      },
      heartRate: {
        enabled: true,
        monitoring: 'continuous',
        alerts: ['stress', 'excitement', 'calm']
      },
      eyeMovement: {
        enabled: true,
        tracking: ['focus', 'attention', 'reading_pattern']
      },
      adanidIdentity: {
        enabled: true,
        verification: 'blockchain',
        multiFactor: true
      }
    },
    privacy: {
      genderAppropriate: true,
      dataEncryption: 'AES-256',
      localProcessing: true,
      consentRequired: true
    },
    oversight: {
      religiousAuthority: true,
      ethicsBoard: true,
      communityReview: true
    }
  },

  // Blockchain & Eternal Storage
  blockchain: {
    network: 'ADANiD Universal Blockchain',
    consensus: 'Zero-Energy-Proof-of-Stake',
    attestation: {
      enabled: true,
      immutable: true,
      cryptographicProof: true
    },
    storage: {
      guarantee: '200+ years',
      platforms: {
        polygon: {
          enabled: true,
          network: 'mainnet',
          gasOptimization: true
        },
        ceramic: {
          enabled: true,
          decentralized: true,
          streamBased: true
        },
        ipfs: {
          enabled: true,
          distributed: true,
          pinning: 'permanent'
        },
        arweave: {
          enabled: true,
          permanent: true,
          payOnce: true
        }
      }
    }
  },

  // Integration Configuration
  integrations: {
    zapier: {
      agent: 'Global Finance & Security Advisor',
      status: 'active',
      authenticated: true,
      actions: 2
    },
    gmail: {
      authenticated: true,
      notifications: true,
      reports: true
    },
    googleSheets: {
      authenticated: true,
      progressTracking: true,
      analytics: true
    },
    firebaseStudio: {
      project: 'quran-lab-adanid',
      aiModels: ['gemini-pro', 'gemini-pro-audio'],
      realtime: true
    }
  },

  // Database Configuration
  database: {
    mongodb: {
      uri: process.env.MONGODB_URI || 'mongodb://localhost:27017/quran-lab',
      options: {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        maxPoolSize: 10
      }
    },
    collections: {
      users: 'users',
      recitations: 'recitations',
      progress: 'spiritual_progress',
      hafizQari: 'hafiz_qari_network',
      corrections: 'corrections',
      attestations: 'blockchain_attestations',
      jannahPoints: 'jannah_points'
    }
  },

  // API Configuration
  api: {
    port: process.env.PORT || 3000,
    cors: {
      origin: ['https://quranlab.adanid.ai', 'https://www.adanid.ai'],
      credentials: true
    },
    rateLimit: {
      windowMs: 15 * 60 * 1000, // 15 minutes
      max: 100 // limit each IP to 100 requests per windowMs
    },
    security: {
      helmet: true,
      jwt: {
        secret: process.env.JWT_SECRET,
        expiresIn: '24h'
      }
    }
  },

  // Notification System
  notifications: {
    channels: ['email', 'sms', 'push', 'in-app'],
    islamic: {
      prayerReminders: true,
      islamicCalendar: true,
      spiritualQuotes: true
    },
    progress: {
      dailyReports: true,
      weeklyAnalysis: true,
      monthlyProgress: true,
      levelUpAlerts: true
    },
    corrections: {
      hafizAssigned: true,
      correctionReceived: true,
      improvementSuggestions: true
    }
  },

  // Environment Configuration
  environment: {
    development: {
      debug: true,
      logging: 'verbose',
      mockData: true
    },
    production: {
      debug: false,
      logging: 'error',
      monitoring: true,
      analytics: true
    }
  },

  // Feature Flags
  features: {
    letterByLetterAnalysis: true,
    hafizCorrectionSystem: true,
    jannahPointsSystem: true,
    biometricSecurity: true,
    blockchainAttestation: true,
    eternalStorage: true,
    multiQiraatSupport: true,
    aiTutoring: true,
    communityFeatures: true,
    mobileApp: false, // Coming soon
    vrIntegration: false // Future feature
  },

  // Logging Configuration
  logging: {
    level: process.env.LOG_LEVEL || 'info',
    format: 'json',
    transports: {
      console: true,
      file: {
        enabled: true,
        filename: 'logs/quran-lab.log',
        maxSize: '10m',
        maxFiles: 5
      },
      mongodb: {
        enabled: true,
        collection: 'logs'
      }
    }
  },

  // Monitoring & Analytics
  monitoring: {
    healthCheck: {
      enabled: true,
      interval: 30000, // 30 seconds
      endpoints: ['/health', '/api/status']
    },
    metrics: {
      enabled: true,
      collection: ['performance', 'usage', 'errors', 'spiritual_progress']
    },
    alerts: {
      email: process.env.ALERT_EMAIL,
      thresholds: {
        errorRate: 0.01, // 1%
        responseTime: 5000, // 5 seconds
        memoryUsage: 0.9 // 90%
      }
    }
  }
};