
const express = require('express');
const router = express.Router();
const { register, login,totaluser, logout } = require('../controller/authcontroller');
const verifyToken = require('../middleware/Authmiddleware');


router.post('/register', register);  
router.post('/login', login);     
router.get('/totaluser', totaluser);     

router.post('/logout', verifyToken, logout);

module.exports = router;
