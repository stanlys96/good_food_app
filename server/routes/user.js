const express = require('express');
const router = express.Router();
const UserController = require('../controllers/UserController');

router.get('/:email', UserController.getUser);
router.post('/register', UserController.register);
router.post('/login', UserController.login);
router.post('/addToCart', UserController.addToCart);

module.exports = router;