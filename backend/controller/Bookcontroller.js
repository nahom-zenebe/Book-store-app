const Book = require('../model/Bookmode');
const Category = require('../model/Categorymodel');

// @desc Get all books
// @route GET /api/books
exports.getAllBooks = async (req, res) => {
  try {
    const books = await Book.find().populate('category').sort({ createdAt: -1 });
    res.status(200).json(books);
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};

// @desc Get single book by ID
// @route GET /api/books/:id
exports.getBookById = async (req, res) => {
  try {
    const book = await Book.findById(req.params.id).populate('category');
    if (!book) return res.status(404).json({ message: 'Book not found' });
    res.status(200).json(book);
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};

// @desc Create a new book
// @route POST /api/books
exports.createBook = async (req, res) => {
  try {
    const { title, author, category, description, price, coverImage, featured } = req.body;

    const categoryExists = await Category.findById(category);
    if (!categoryExists) return res.status(400).json({ message: 'Invalid category' });

    const newBook = new Book({
      title,
      author,
      category,
      description,
      price,
      coverImage,
      featured,
    });

    const saved = await newBook.save();
    res.status(201).json(saved);
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};

// @desc Update book
// @route PUT /api/books/:id
exports.updateBook = async (req, res) => {
  try {
    const updated = await Book.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });
    if (!updated) return res.status(404).json({ message: 'Book not found' });
    res.status(200).json(updated);
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};

// @desc Delete book
// @route DELETE /api/books/:id
exports.deleteBook = async (req, res) => {
  try {
    const deleted = await Book.findByIdAndDelete(req.params.id);
    if (!deleted) return res.status(404).json({ message: 'Book not found' });
    res.status(200).json({ message: 'Book deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};


exports.search = async (req, res) => {
  try {
    const { bookinfo } = req.query;

    if (!bookinfo || bookinfo.trim() === '') {
      return res.status(400).json({ message: 'Search query is required' });
    }

    const results = await Book.find({
      $or: [
        { title: { $regex: bookinfo, $options: 'i' } },
        { author: { $regex: bookinfo, $options: 'i' } },
       
      ],
    })

    res.status(200).json(results);
  } catch (error) {
    console.error("Error during search:", error);
    res.status(500).json({ message: 'Server Error', error: error.message });  
  }
};
