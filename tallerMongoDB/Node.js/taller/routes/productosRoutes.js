const express = require("express");
const router = express.Router();
const Producto = require("../models/productos");

// registrar producto
router.post('/registrar', async (req, res) => {
    try {
        const producto = new Producto(req.body);
        await producto.save();
        res.status(201).json(producto);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// obtener todos los productos
router.get('/', async (req, res) => {
    try {
        const productos = await Producto.find();
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// productos con precio mayor a 100
router.get('/mayor100', async (req, res) => {
    try {
        const productos = await Producto.find({ precio: { $gt: 100 } });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// consultar por precio de manera descendente
router.get('/precioDesc', async (req, res) => {
    try {
        const productos = await Producto.find().sort({ precio: -1 });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// cabiar valor de stock a false para todos los productos con precio menor a 500+
router.put('/cambiarStock', async (req, res) => {
    try {
        const productos = await Producto.updateMany({ precio: { $lt: 500 } }, { stock: false });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// eliminar producto con precio menor a 50
router.delete('/eliminarMenor50', async (req, res) => {
    try {
        const productos = await Producto.deleteMany({ precio: { $lt: 50 } });
        res.json(productos);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});



module.exports = router;