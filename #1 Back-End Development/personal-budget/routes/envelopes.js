const express = require('express');
const router = express.Router();
const envelopes = require('../models/envelopes');
const validateTransaction = require('../utils/validate');

// GET all envelopes
router.get('/', (req, res) => {
  res.json(envelopes);
});

// GET a specific envelope
router.get('/:id', (req, res) => {
  const envelope = envelopes.find(env => env.id === parseInt(req.params.id));
  if (!envelope) {
    return res.status(404).send('Envelope not found.');
  }
  res.json(envelope);
});

// POST a new envelope
router.post('/', (req, res) => {
  const { category, balance } = req.body;

  if (!category || balance == null) {
    return res.status(400).send('Category and balance are required.');
  }

  const newEnvelope = {
    id: envelopes.length > 0 ? envelopes[envelopes.length - 1].id + 1 : 1,
    category,
    balance: parseFloat(balance),
  };

  envelopes.push(newEnvelope);
  res.status(201).json(newEnvelope);
});

// PUT (update an envelope)
router.put('/:id', (req, res) => {
  const { category, balance } = req.body;
  const envelope = envelopes.find(env => env.id === parseInt(req.params.id));

  if (!envelope) {
    return res.status(404).send('Envelope not found.');
  }

  if (category) envelope.category = category;
  if (balance != null) envelope.balance = parseFloat(balance);

  res.json(envelope);
});

// DELETE an envelope
router.delete('/:id', (req, res) => {
  const envelopeIndex = envelopes.findIndex(env => env.id === parseInt(req.params.id));
  if (envelopeIndex === -1) {
    return res.status(404).send('Envelope not found.');
  }

  envelopes.splice(envelopeIndex, 1);
  res.status(204).send();
});

// POST a transaction (update balance)
router.post('/:id/transactions', (req, res) => {
  const envelope = envelopes.find(env => env.id === parseInt(req.params.id));

  if (!envelope) {
    return res.status(404).send('Envelope not found.');
  }

  const { amount } = req.body;

  if (amount == null || !validateTransaction(envelope.balance, amount)) {
    return res.status(400).send('Invalid or insufficient balance.');
  }

  envelope.balance -= parseFloat(amount);
  res.json(envelope);
});

module.exports = router;
