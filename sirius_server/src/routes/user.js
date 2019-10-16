const { Router } = require('express');
const router = Router();
//require('/public/main.js')

router.get('/api/users', (req, res) => {
    res.json('User list');
});