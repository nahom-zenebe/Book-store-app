const express = require('express');
const router = express.Router();
const orderController = require('../controller/ordercontroller');
const verifyToken = require('../middleware/Authmiddleware');

// All order routes require authentication
router.use(verifyToken);

// Create new order
router.post('/create', orderController.createOrder);

// Get user's orders
router.get('/user-orders', orderController.getUserOrders);

// Get order by ID
router.get('/:orderId', orderController.getOrderById);

// Update order status (admin only)
router.put('/:orderId/status', orderController.updateOrderStatus);

// Cancel order
router.put('/:orderId/cancel', orderController.cancelOrder);

// Get order statistics (admin only)
router.get('/stats/overview', orderController.getOrderStats);

module.exports = router; 