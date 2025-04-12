require('dotenv').config()
const express = require('express');
const cookieParser = require('cookie-parser');
const mongoose = require('mongoose');
const authRoutes = require('./router/prorouter');

const cors=require('cors')
const app = express()




app.use(express.json()); 
app.use(cookieParser());     
app.use(cors({
  origin: "*", 
  methods: ["GET", "POST", "PUT", "DELETE"],
  credentials: true  
}));

app.use('/api/auth', authRoutes);








const mongoURI =process.env.Mongodb;

mongoose.connect(mongoURI, {

})
.then(() => console.log('MongoDB connected'))
.catch((err) => console.log('Database connection error:', err));


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
