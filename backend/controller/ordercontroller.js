const Order = require("../model/Ordermodel");
const Book = require("../model/Bookmode");

const orderController = {
  // Create new order
  createOrder: async (req, res) => {
    try {
      const { items, shippingAddress, paymentMethod } = req.body;
      const userId = req.user.id; // From auth middleware

      if (!items || items.length === 0) {
        return res.status(400).json({ message: 'Order must contain at least one item' });
      }

      // Calculate total amount and validate items
      let totalAmount = 0;
      const orderItems = [];

      for (const item of items) {
        const book = await Book.findById(item.bookId);
        if (!book) {
          return res.status(404).json({ message: `Book with ID ${item.bookId} not found` });
        }

        const itemTotal = book.price * item.quantity;
        totalAmount += itemTotal;

        orderItems.push({
          book: item.bookId,
          quantity: item.quantity,
          price: book.price
        });
      }

      // Apply discount if applicable (10% off for orders over $50)
      let discount = 0;
      if (totalAmount > 50) {
        discount = totalAmount * 0.1;
      }

      const order = new Order({
        user: userId,
        items: orderItems,
        totalAmount,
        discount,
        finalAmount: totalAmount - discount,
        paymentMethod,
        shippingAddress,
        status: 'pending',
        paymentStatus: 'pending'
      });

      await order.save();

      res.status(201).json({
        success: true,
        message: 'Order created successfully',
        order
      });
    } catch (error) {
      console.error('Create order error:', error);
      res.status(500).json({ message: 'Failed to create order' });
    }
  },

  // Get user's orders
  getUserOrders: async (req, res) => {
    try {
      const userId = req.user.id;
      const { page = 1, limit = 10, status } = req.query;

      const query = { user: userId };
      if (status) {
        query.status = status;
      }

      const orders = await Order.find(query)
        .populate('items.book', 'title author coverImage price')
        .sort({ createdAt: -1 })
        .limit(limit * 1)
        .skip((page - 1) * limit)
        .exec();

      const total = await Order.countDocuments(query);

      res.json({
        orders,
        totalPages: Math.ceil(total / limit),
        currentPage: page,
        totalOrders: total
      });
    } catch (error) {
      console.error('Get user orders error:', error);
      res.status(500).json({ message: 'Failed to fetch orders' });
    }
  },

  // Get order by ID
  getOrderById: async (req, res) => {
    try {
      const { orderId } = req.params;
      const userId = req.user.id;

      const order = await Order.findById(orderId)
        .populate('items.book', 'title author coverImage price description')
        .populate('user', 'name email');

      if (!order) {
        return res.status(404).json({ message: 'Order not found' });
      }

      // Check if user owns this order or is admin
      if (order.user._id.toString() !== userId && req.user.role !== 'admin') {
        return res.status(403).json({ message: 'Access denied' });
      }

      res.json(order);
    } catch (error) {
      console.error('Get order by ID error:', error);
      res.status(500).json({ message: 'Failed to fetch order' });
    }
  },

  // Update order status (admin only)
  updateOrderStatus: async (req, res) => {
    try {
      const { orderId } = req.params;
      const { status, trackingNumber, estimatedDelivery } = req.body;

      if (req.user.role !== 'admin') {
        return res.status(403).json({ message: 'Admin access required' });
      }

      const order = await Order.findById(orderId);
      if (!order) {
        return res.status(404).json({ message: 'Order not found' });
      }

      order.status = status;
      if (trackingNumber) order.trackingNumber = trackingNumber;
      if (estimatedDelivery) order.estimatedDelivery = estimatedDelivery;

      await order.save();

      res.json({
        success: true,
        message: 'Order status updated successfully',
        order
      });
    } catch (error) {
      console.error('Update order status error:', error);
      res.status(500).json({ message: 'Failed to update order status' });
    }
  },

  // Cancel order
  cancelOrder: async (req, res) => {
    try {
      const { orderId } = req.params;
      const userId = req.user.id;

      const order = await Order.findById(orderId);
      if (!order) {
        return res.status(404).json({ message: 'Order not found' });
      }

      // Check if user owns this order
      if (order.user.toString() !== userId) {
        return res.status(403).json({ message: 'Access denied' });
      }

      // Only allow cancellation if order is still pending
      if (order.status !== 'pending') {
        return res.status(400).json({ message: 'Order cannot be cancelled at this stage' });
      }

      order.status = 'cancelled';
      await order.save();

      res.json({
        success: true,
        message: 'Order cancelled successfully',
        order
      });
    } catch (error) {
      console.error('Cancel order error:', error);
      res.status(500).json({ message: 'Failed to cancel order' });
    }
  },

  // Get order statistics (admin only)
  getOrderStats: async (req, res) => {
    try {
      if (req.user.role !== 'admin') {
        return res.status(403).json({ message: 'Admin access required' });
      }

      const totalOrders = await Order.countDocuments();
      const pendingOrders = await Order.countDocuments({ status: 'pending' });
      const completedOrders = await Order.countDocuments({ status: 'delivered' });
      const totalRevenue = await Order.aggregate([
        { $match: { paymentStatus: 'completed' } },
        { $group: { _id: null, total: { $sum: '$finalAmount' } } }
      ]);

      res.json({
        totalOrders,
        pendingOrders,
        completedOrders,
        totalRevenue: totalRevenue[0]?.total || 0
      });
    } catch (error) {
      console.error('Get order stats error:', error);
      res.status(500).json({ message: 'Failed to fetch order statistics' });
    }
  }
};

module.exports = orderController;
