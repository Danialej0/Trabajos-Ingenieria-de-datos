const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

// Importar las rutas
const usuarioRoutes = require("./routes/usuarioRoutes");
const productoRoutes = require("./routes/productosRoutes");


const app = express()
const port = 3000


// Middleware

app.use(bodyParser.json());
app.use(cors());

// conexion a mongo

mongoose.connect('mongodb://localhost:27017/taller',{  // explicacion miapp: NOMBRE DE LA BASE DE DATOS DE MONGO
  useNewUrlParser:true,
  useUnifiedTopology:true,
})
.then(()=>console.log('MongoDB Conectado'))
.catch(err=>console.err(err))

//usar las rutas
app.use('/api/usuario', usuarioRoutes);
app.use('/api/producto', productoRoutes);

// Ruta de prueba
app.listen(port, ()=>{
  console.log(`servidor conectado en http://localhost:${port}`)
});