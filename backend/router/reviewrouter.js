const express = require('express');
const router = express.Router();
const reviewController = require('../controller/reviewcontroller');


router.get('/book/:bookId', reviewController.getReviewsByBook);
router.post('/:bookId', protect, reviewController.createReview);
router.delete('/:id', protect, reviewController.deleteReview);

module.exports = router;
