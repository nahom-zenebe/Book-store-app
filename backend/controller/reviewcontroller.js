const Review = require('../model/Reviewmodel');
const Book = require('../model/Bookmode');

// @desc Get all reviews for a book
// @route GET /api/reviews/book/:bookId
exports.getReviewsByBook = async (req, res) => {
  try {
    const reviews = await Review.find({ book: req.params.bookId }).populate('user', 'name');
    res.status(200).json(reviews);
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};

// @desc Create a review for a book
// @route POST /api/reviews/:bookId
exports.createReview = async (req, res) => {
  try {
    const { rating, comment } = req.body;
    const userId = req.user._id; // assume user is authenticated

    const book = await Book.findById(req.params.bookId);
    if (!book) return res.status(404).json({ message: 'Book not found' });

    const existingReview = await Review.findOne({ user: userId, book: req.params.bookId });
    if (existingReview) return res.status(400).json({ message: 'You already reviewed this book' });

    const review = new Review({
      user: userId,
      book: req.params.bookId,
      rating,
      comment,
    });

    await review.save();

    // Update book's average rating
    const reviews = await Review.find({ book: req.params.bookId });
    const avgRating = reviews.reduce((acc, r) => acc + r.rating, 0) / reviews.length;
    book.rating = avgRating;
    book.numReviews = reviews.length;
    await book.save();

    res.status(201).json(review);
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};

// @desc Delete a review
// @route DELETE /api/reviews/:id
exports.deleteReview = async (req, res) => {
  try {
    const review = await Review.findById(req.params.id);
    if (!review) return res.status(404).json({ message: 'Review not found' });

    await review.deleteOne();

    // Update book ratings
    const book = await Book.findById(review.book);
    const reviews = await Review.find({ book: review.book });
    const avgRating = reviews.length
      ? reviews.reduce((acc, r) => acc + r.rating, 0) / reviews.length
      : 0;

    book.rating = avgRating;
    book.numReviews = reviews.length;
    await book.save();

    res.status(200).json({ message: 'Review deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Server Error', error: err });
  }
};
