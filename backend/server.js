require('dotenv').config()
const express = require('express');
const cookieParser = require('cookie-parser');
const mongoose = require('mongoose');
const authRoutes = require('./router/prorouter');
const bookrouter=require('./router/bookrouter')
const cateogryrouter=require('./router/categoryrouter')
const reivewrouter=require('./router/reviewrouter')
const cors=require('cors')
const app = express()




app.use(express.json()); 
app.use(cookieParser());     
app.use(cors({
  origin: "http://localhost:49502", 
  methods: ["GET", "POST", "PUT", "DELETE"],
  credentials: true  
}));

app.use('/api/auth', authRoutes);
app.use('/api/books',bookrouter)
app.use('/api/Category', cateogryrouter);
app.use('/api/review',reivewrouter)









const mongoURI =process.env.Mongodb;

mongoose.connect(mongoURI, {

})
.then(() => console.log('MongoDB connected'))
.catch((err) => console.log('Database connection error:', err));


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
