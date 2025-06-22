const express = require('express');
const router = express.Router();
const paymentController = require('../controller/paymentcontroller');
const verifyToken = require('../middleware/Authmiddleware');

// All payment routes require authentication
router.use(verifyToken);

// Create payment intent
router.post('/create-payment-intent', paymentController.createPaymentIntent);

// Confirm payment
router.post('/confirm-payment', paymentController.confirmPayment);

// Get payment status
router.get('/payment-status/:orderId', paymentController.getPaymentStatus);

// Refund payment
router.post('/refund-payment', paymentController.refundPayment);

module.exports = router; 