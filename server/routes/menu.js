const express = require('express');
const router = express.Router();
const MenuController = require('../controllers/MenuController');

router.post('/', MenuController.querySearch);
router.post('/category', MenuController.getByCategory);
router.get('/burgers', MenuController.getBurgers);
router.get('/noodles', MenuController.getNoodles);
router.get('/drinks', MenuController.getDrinks);
router.get('/snacks', MenuController.getSnacks);
router.get('/all', MenuController.getAll);

module.exports = router;