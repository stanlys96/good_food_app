const express = require('express');
const router = express.Router();
const userRoutes = require('./user');
const menuRoutes = require('./menu');
const categoryRoutes = require('./category');

router.use('/user', userRoutes);
router.use('/menu', menuRoutes);
router.use('/category', categoryRoutes);

module.exports = router;