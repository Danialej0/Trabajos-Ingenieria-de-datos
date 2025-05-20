const mongoose = require('mongoose');


const clienteSchema = new mongoose.Schema({
    nombre: {type: String, required: true},
    edad: {type: Number, required: true},
    correo: {type: String, required: true},
    activo: {type: Boolean, default: true},
})

module.exports = mongoose.model('usuario', clienteSchema);