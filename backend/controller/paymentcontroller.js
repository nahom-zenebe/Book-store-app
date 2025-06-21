const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const Order = require('../model/Ordermodel');
const User = require('../model/user');

const paymentController = {
  // Create payment intent
  createPaymentIntent: async (req, res) => {
    try {
      const { orderId } = req.body;
      
      const order = await Order.findById(orderId).populate('items.book');
      if (!order) {
        return res.status(404).json({ message: 'Order not found' });
      }

      if (order.paymentStatus === 'completed') {
        return res.status(400).json({ message: 'Order already paid' });
      }

      const paymentIntent = await stripe.paymentIntents.create({
        amount: Math.round(order.finalAmount * 100), // Convert to cents
        currency: 'usd',
        metadata: {
          orderId: order._id.toString(),
          userId: order.user.toString()
        }
      });

      // Update order with payment intent ID
      order.paymentIntentId = paymentIntent.id;
      await order.save();

      res.json({
        clientSecret: paymentIntent.client_secret,
        orderId: order._id
      });
    } catch (error) {
      console.error('Payment intent creation error:', error);
      res.status(500).json({ message: 'Payment processing failed' });
    }
  },

  // Confirm payment
  confirmPayment: async (req, res) => {
    try {
      const { paymentIntentId, orderId } = req.body;

      const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);
      
      if (paymentIntent.status === 'succeeded') {
        const order = await Order.findById(orderId);
        if (order) {
          order.paymentStatus = 'completed';
          order.status = 'processing';
          await order.save();
        }

        res.json({ 
          success: true, 
          message: 'Payment confirmed successfully',
          order: order
        });
      } else {
        res.status(400).json({ 
          success: false, 
          message: 'Payment not completed' 
        });
      }
    } catch (error) {
      console.error('Payment confirmation error:', error);
      res.status(500).json({ message: 'Payment confirmation failed' });
    }
  },

  // Get payment status
  getPaymentStatus: async (req, res) => {
    try {
      const { orderId } = req.params;
      
      const order = await Order.findById(orderId);
      if (!order) {
        return res.status(404).json({ message: 'Order not found' });
      }

      res.json({
        paymentStatus: order.paymentStatus,
        orderStatus: order.status,
        amount: order.finalAmount
      });
    } catch (error) {
      console.error('Get payment status error:', error);
      res.status(500).json({ message: 'Failed to get payment status' });
    }
  },

  // Refund payment
  refundPayment: async (req, res) => {
    try {
      const { orderId, reason } = req.body;
      
      const order = await Order.findById(orderId);
      if (!order) {
        return res.status(404).json({ message: 'Order not found' });
      }

      if (order.paymentStatus !== 'completed') {
        return res.status(400).json({ message: 'Order not paid' });
      }

      const refund = await stripe.refunds.create({
        payment_intent: order.paymentIntentId,
        reason: reason || 'requested_by_customer'
      });

      order.paymentStatus = 'refunded';
      order.status = 'cancelled';
      await order.save();

      res.json({ 
        success: true, 
        message: 'Refund processed successfully',
        refundId: refund.id
      });
    } catch (error) {
      console.error('Refund error:', error);
      res.status(500).json({ message: 'Refund processing failed' });
    }
  }
};

module.exports = paymentController;
