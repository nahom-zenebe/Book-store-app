
const jwt = require('jsonwebtoken');
const User = require('../model/user');


require('dotenv').config()



const generateToken = (userId) => {
  return jwt.sign({ userId }, process.env.JWT_SECRET, { expiresIn: '1h' });
};


exports.register = async (req, res) => {
  const { name, email, password, role } = req.body;

  try {
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ message: 'User already exists' });
    }

    user = new User({ name, email, password, role });
    await user.save();

    const token = generateToken(user._id);
    
   
    res.cookie('token', token, { httpOnly: true, secure: process.env.NODE_ENV === 'production' })
      .status(201)
      .json({
        message: 'User registered successfully',
        user: {
          name: user.name,
          email: user.email,
          role: user.role,
        },
      });
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
};

exports.totaluser=async(req,res)=>{
  try{
    const totaluser=await User.countDocuments()

    res.status(200).json(totaluser)

  }
  catch(error){
    res.status(500).json({ message: 'Server error' });
  }
}



exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    let user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    const isMatch = await user.comparePassword(password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    const token = generateToken(user._id);
    res.cookie('token', token, { httpOnly: true, secure: process.env.NODE_ENV === 'production' })
      .status(200)
      .json({ message: 'Logged in successfully', user: {
        name: user.name,
        email: user.email,
        role: user.role,
      }, });
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
};


exports.logout = (req, res) => {
  res.clearCookie('token')
     .status(200)
     .json({ message: 'Logged out successfully' });
};
