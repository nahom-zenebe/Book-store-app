const express = require('express');
const router = express.Router();
const categoryController = require('../controller/categorycontroller');

// CRUD routes
router.get('//getallcreateCategory', categoryController.getAllCategories);
router.get('/getallcreateCategory/:id', categoryController.getCategoryById);
router.post('/createCategory', categoryController.createCategory);
router.put('/updateCategory/:id', categoryController.updateCategory);
router.delete('/deleteCategory/:id', categoryController.deleteCategory);

module.exports = router;
