const express = require('express');
const app = express();
const envelopeRoutes = require('./routes/envelopes');

app.use(express.json());
app.use('/api/envelopes', envelopeRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
