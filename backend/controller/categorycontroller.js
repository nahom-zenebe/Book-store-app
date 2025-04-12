const Category = require('../model/Categorymodel');

// @desc    Get all categories
// @route   GET /api/categories
exports.getAllCategories = async (req, res) => {
  try {
    const categories = await Category.find().sort({ name: 1 });
    res.status(200).json(categories);
  } catch (error) {
    res.status(500).json({ message: 'Server Error', error });
  }
};

// @desc    Get single category by ID
// @route   GET /api/categories/:id
exports.getCategoryById = async (req, res) => {
  try {
    const category = await Category.findById(req.params.id);
    if (!category) return res.status(404).json({ message: 'Category not found' });
    res.status(200).json(category);
  } catch (error) {
    res.status(500).json({ message: 'Server Error', error });
  }
};

// @desc    Create new category
// @route   POST /api/categories
exports.createCategory = async (req, res) => {
  try {
    const { name, description } = req.body;

    // Check for duplicate
    const existing = await Category.findOne({ name });
    if (existing) return res.status(400).json({ message: 'Category already exists' });

    const newCategory = new Category({ name, description });
    const saved = await newCategory.save();

    res.status(201).json(saved);
  } catch (error) {
    res.status(500).json({ message: 'Server Error', error });
  }
};

// @desc    Update category
// @route   PUT /api/categories/:id
exports.updateCategory = async (req, res) => {
  try {
    const { name, description } = req.body;

    const updated = await Category.findByIdAndUpdate(
      req.params.id,
      { name, description },
      { new: true, runValidators: true }
    );

    if (!updated) return res.status(404).json({ message: 'Category not found' });

    res.status(200).json(updated);
  } catch (error) {
    res.status(500).json({ message: 'Server Error', error });
  }
};

// @desc    Delete category
// @route   DELETE /api/categories/:id
exports.deleteCategory = async (req, res) => {
  try {
    const deleted = await Category.findByIdAndDelete(req.params.id);
    if (!deleted) return res.status(404).json({ message: 'Category not found' });
    res.status(200).json({ message: 'Category deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Server Error', error });
  }
};
