const express = require("express");
const router = express.Router();
const Usuario = require("../models/usuarios");

// registrar usuario

router.post('/registrar', async(req, res) => {
    try {
        const usuario = new Usuario(req.body);
        await usuario.save();
        res.status(201).json(usuario);
    }catch (error){
        res.status(400).json({error: error.message});
    }

})

// obtener todos los usuarios

router.get('/', async(req, res) => {
    try {
        const usuarios = await Usuario.find();
        res.json(usuarios);
    }catch (error){
        res.status(500).json({error: error.message});
    }
})

// usuarios mayores a 30 años
router.get('/mayores30', async(req, res) => {
    try {
        const usuarios = await Usuario.find({edad: {$gt: 30}});
        res.json(usuarios);
    }catch (error){
        res.status(500).json({error: error.message});
    }
})

// usuario por nombre
router.get('/:nombre', async(req, res) => {
    try {
        const usuario = await Usuario.findOne({nombre: req.params.nombre});
        if (!usuario) {
            return res.status(404).json({error: 'Usuario no encontrado'});
        }
        res.json(usuario);
    }catch (error){
        res.status(500).json({error: error.message});
    }
})

// cambiar edad de usuario
router.put('/actEdad/:nombre', async (req, res) => {
    try { 
        const { edad } = req.body;
        const usuario = await Usuario.findOneAndUpdate({ nombre: req.params.nombre }, { edad: edad }, { new: true });
        if (!usuario) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        }
        res.json(usuario);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// activo: true a todos los usuarios con edad mayor o igual a 30 años.
router.put('/activa30', async (req, res) => {
    try {
        const usuarios = await Usuario.updateMany({ edad: { $gte: 30 } }, { activo: true });
        res.json(usuarios);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// eliminar usuario por nombre
router.delete('/eliminar/:nombre', async (req, res) => {
    try {
        const usuario = await Usuario.findOneAndDelete({ nombre: req.params.nombre });
        if (!usuario) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        }
        res.json(usuario);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// eliminar usuarios menores a 30 años
router.delete('/eliminarMenores30', async (req, res) => {
    try {
        const usuarios = await Usuario.deleteMany({ edad: { $lt: 30 } });
        res.json(usuarios);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//exportar las rutas

module.exports = router;



