const express = require('express');
const router = express.Router();
const bookController = require('../controller/Bookcontroller');

router.get('/getallrouter', bookController.getAllBooks);
router.get('/routerbyid/:id', bookController.getBookById);
router.post('/createrouter', bookController.createBook);
router.put('/updaterouter/:id', bookController.updateBook);
router.delete('/deleterouter/:id', bookController.deleteBook);

module.exports = router;
