const express = require('express');
const router = express.Router();
const MenuController = require('../controllers/MenuController');

router.post('/', MenuController.querySearch);
router.post('/:category/:id', MenuController.getById);
router.post('/category', MenuController.getByCategory);
router.get('/all', MenuController.getAll);

module.exports = router;