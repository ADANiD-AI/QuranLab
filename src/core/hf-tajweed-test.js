// src/core/hf-tajweed-test.js
const { HfInference } = require('@huggingface/inference');

const hf = new HfInference('hf_your_token_here'); // Free token from huggingface.co

async function testTajweed() {
  const result = await hf.automaticSpeechRecognition({
    model: 'tarteel-ai/whisper-base-ar-quran',
    inputs: 'https://example.com/sample-quran-recitation.wav' // Test audio
  });

  console.log('Transcribed Text:', result.text);

  const tajweed = await hf.textClassification({
    model: 'Habib-HF/tarbiyah-ai-v1-1',
    inputs: result.text
  });

  const errors = tajweed.filter(t => t.score < 0.8).map(t => t.label);
  console.log('Tajweed Errors:', errors);
  console.log('Score:', Math.round(tajweed[0].score * 100), '%');
}

testTajweed().catch(console.error);
