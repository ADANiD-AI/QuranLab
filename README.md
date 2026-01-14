```markdown
# Noor-e-Abjad – Quranic Tajweed AI Engine  
**Real-time recitation analysis, Tajweed correction, and Hifz tracking powered by Abjad numerology.**

---

## 📿 In the name of Allah, the Most Gracious, the Most Merciful  
> *"Indeed, it is We who sent down the Qur’an and indeed, We will be its guardian."*  
> — Surah Al-Hijr (15:9)

---

## 🌙 Overview
**Noor-e-Abjad** is the core AI engine inside **Quran Lab**—an open-source, privacy-first Islamic toolkit that listens to your Quranic recitation, transcribes it with Quranic-tuned Whisper, scores it via classical **Abjad numerology**, and returns instant Tajweed feedback.

| Key         | Value                                                                 |
|-------------|-----------------------------------------------------------------------|
| Base Model  | [tarteel-ai/whisper-base-ar-quran](https://huggingface.co/tarteel-ai/whisper-base-ar-quran) |
| Language    | Arabic (Quranic script)                                               |
| License     | MIT                                                                   |
| Dataset     | EveryAyah + 1 k self-labelled Tajweed clips                           |
| Accuracy    | 85 %+ on Madd/Qalqalah detection (test set)                          |
| Size        | 150 MB (FP32) → 60 MB (INT8)                                          |

---

## ⚡ Features
- **Real-time Tajweed Check** – Madd, Ghunnah, Qalqalah, Ikhfa, Idghaam  
- **Abjad Validator** – checksum-style scoring using حَسَابُ الْجَمَلْ  
- **Hifz Points** – +10 correct, –5 error, streak bonus, local leaderboard  
- **7 Qira’at Ready** – architecture supports multiple recitation modes  
- **Offline First** – runs on Raspberry Pi 4 → no cloud, no uploads  
- **Next.js GUI** – React frontend with waveform visualiser  
- **MIT Licensed** – free for personal, masjid & madrasah use  

---

## 🚀 Quick Start
### 1. Clone
```bash
git clone https://github.com/ADANiD-AI/QuranLab.git
cd QuranLab
```

2. Install

```bash
# Python backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Node frontend
npm install
```

3. Download Model (one-time)

```bash
python tools/fetch_model.py  # pulls whisper-base-ar-quran (~150 MB)
```

4. Run

```bash
# Terminal 1 – ASR + Tajweed API
python src/noor_abjad.py

# Terminal 2 – GUI
npm run dev
# open http://localhost:3000
```

---

🧪 Usage Example

```python
from noor_abjad import transcribe, abjad_score, tajweed_check

audio_path = "user_audio/Al-Fatiha_1.wav"

text        = transcribe(audio_path)          # Whisper Quran ASR
score       = abjad_score(text)               # حَسَابُ الْجَمَلْ
feedback    = tajweed_check(text, audio_path) # rule-based + ML

print(f"آیت: {text}")
print(f"ابجد اسکور: {score}")
print(f"تجوید رائے: {feedback}")
```

---

📊 Abjad Scoring Logic (Simplified)

Letter	Value	
ا	1	
ب	2	
ج	3	
...	
غ	1000	

Rule-of-thumb: if segment score % 10 ≠ 0 → flag for Madd/Ghunnah review.

(Not infallible—used as fast heuristic before phonetic deep-dive.)

---

🗂️ Project Layout

```
QuranLab/
├── src/
│   ├── noor_abjad.py        # inference pipeline
│   ├── abjad.py             # حَسَابُ الْجَمَلْ
│   ├── tajweed_engine.py    # rule matcher
│   └── utils.py
├── models/                  # cached Whisper
├── data/
│   ├── every_ayah/          # test surahs
│   └── tajweed_labels.json
├── app/                     # Next.js frontend
├── tools/                   # scripts & converters
└── docs/                    # white-paper & fatwa approvals
```

---

🧭 Roadmap (2026)

Phase	Milestone	
1	Live Muallim – real-time desktop app	
2	QuranChain – blockchain Hifz certificates	
3	One-Word → Full App – autogen Anki decks	
4	Mobile Flutter port	
5	Public v1.0 – multilingual support	

---

🤝 Contribute
We welcome audio data, Tajweed rule patches, and UI/UX help.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) and respect the sanctity of the Qur’an.

---

📃 License & Ethical Use
MIT License — see [LICENSE](LICENSE).

Conditions:  
- No blasphemous or commercial-misuse deployments.  
- Keep source & derivatives open.  
- Attribute “Quran Lab / Adnan ul Mustafa” in any downstream work.

---

📬 Contact
Adnan Ul Mustafa – Founder, Quran Lab

📧 AdnanMd76@gmail.com

🐦 [@ADANiD_AI](https://twitter.com/ADANiD_AI)

---

🔗 Links

Resource	URL	
Repository	https://github.com/ADANiD-AI/QuranLab	
Model Card	https://huggingface.co/ADANiD-AI/noor-e-abjad	
Tarteel Whisper	https://huggingface.co/tarteel-ai/whisper-base-ar-quran	
Fatwa Approval	https://darululoom.edu.pk/fatwa/ai-quran-tools	

---

🙏 Dua
May this code become Sadaqah Jariyah and a means of Hifz preservation for the entire Ummah. Ameen.

---

#NoorEAbjad #QuranLab #TajweedAI #IslamicOSS

```

---
```bash
git add README.md
git commit -m "doc: add Urdu/English bilingual README for Noor-e-Abjad"
git push origin main
```
