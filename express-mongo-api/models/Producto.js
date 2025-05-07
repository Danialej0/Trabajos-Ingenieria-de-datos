// UNA CLASE POR COLECCION

const mongoose = require('mongoose');

const itemSchema= new mongoose.Schema({
    nombre:{type:String, requiere:true },       // EXPLICACION: estamos creando las propiedades de la coleccion en formato JSON
    descripcion:String,
    creadoEn: {type:Date, default: Date.now}
})

module.exports=mongoose.model('Item', itemSchema)