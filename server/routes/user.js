const express = require('express');
const router = express.Router();
const UserController = require('../controllers/UserController');

router.get('/:email', UserController.getUser);
router.post('/register', UserController.register);
router.post('/login', UserController.login);
router.post('/:email/addToFavorites', UserController.addToFavorites);
router.post('/:email/addToCart', UserController.addToCart);
router.post('/:email/reduceQuantity', UserController.reduceQuantity);
router.post('/:email/increaseQuantity', UserController.increaseQuantity);
router.delete('/:email', UserController.deleteAllCartItems);
router.delete('/:email/deleteOneItem', UserController.deleteOneItem);
router.delete('/:email/deleteOneFavorite', UserController.deleteOneFavorite);

module.exports = router;