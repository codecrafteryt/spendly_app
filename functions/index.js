const functions = require("firebase-functions");
const admin = require("firebase-admin");
const Anthropic = require("@anthropic-ai/sdk");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);

admin.initializeApp();

const anthropic = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY,
});

exports.generateReport = functions.https.onCall(async (data, context) => {
  const {spenderType, scores, answers} = data;

  const prompt = `You are a friendly, practical financial coach. A user 
just completed a spending-habits quiz.

Spender type: ${spenderType}
Score breakdown: ${JSON.stringify(scores)}
Answers: ${JSON.stringify(answers)}

Write a personalized report with:
1. A warm 2-3 sentence summary of what this spender type means for them
2. Their top 3 specific money "leaks" based on the score breakdown
3. 5 concrete, actionable tips to save more money, tailored to their type
4. A short encouraging closing line

Keep it conversational, specific, and non-judgmental. No generic advice — 
make it feel personal. Output as plain text with clear section breaks, 
no markdown symbols.`;

  const response = await anthropic.messages.create({
    model: "claude-sonnet-4-6",
    max_tokens: 1000,
    messages: [{role: "user", content: prompt}],
  });

  return {reportText: response.content[0].text};
});

exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
  const {amount, currency, sessionId} = data;
  if (!amount || !currency || !sessionId) {
    throw new functions.https.HttpsError(
        "invalid-argument",
        "amount, currency, and sessionId are required",
    );
  }

  const intent = await stripe.paymentIntents.create({
    amount,
    currency,
    metadata: {sessionId},
  });

  return {clientSecret: intent.client_secret};
});

exports.unlockSession = functions.firestore
    .document("sessions/{sessionId}")
    .onUpdate(async (change, context) => {
      const after = change.after.data();
      if (after && after.unlocked === true) {
        return null;
      }
      return null;
    });
