const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  items: [
    {
      book: { type: mongoose.Schema.Types.ObjectId, ref: 'Book', required: true },
      quantity: { type: Number, default: 1 },
    }
  ],
  totalAmount: { type: Number, required: true },
  isPaid: { type: Boolean, default: false },
  paymentMethod: { type: String }, 
  paymentResult: {
    id: String,
    status: String,
    update_time: String,
    email_address: String,
  },
}, { timestamps: true });

module.exports = mongoose.model('Order', orderSchema);
