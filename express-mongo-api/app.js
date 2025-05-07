const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const itemRoutes = require('./routes/productoRoutes')

const app = express()
const port = 3000


// Middleware

app.use(bodyParser.json());
app.use(cors());

// conexion a mongo

mongoose.connect('mongodb://localhost:27017/miapp',{  // explicacion miapp: NOMBRE DE LA BASE DE DATOS DE MONGO
  useNewUrlParser:true,
  useUnifiedTopology:true,
})
.then(()=>console.log('MongoDB Conectado'))
.catch(err=>console.err(err))

//rutas

app.use('api/items', itemRoutes);

app.listen(port, ()=>{
  console.log(`servidor conectado en http://localhost:${port}`)
});
