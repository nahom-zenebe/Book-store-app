const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  book: { type: mongoose.Schema.Types.ObjectId, ref: 'Book', required: true },
  rating: { type: Number, required: true },
  comment: String,
}, { timestamps: true });

module.exports = mongoose.model('Review', reviewSchema);
