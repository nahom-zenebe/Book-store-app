# 📚 Book Store App

A cross-platform online book store application built with **Flutter** (frontend) and **Node.js + MongoDB** (backend). This app offers a seamless user experience for browsing, reviewing, and purchasing books with secure user authentication and integrated payment systems.

---

## 🚀 Features

### 🔐 User Authentication
- Secure user **sign-up** and **login** functionality.
- Backend implemented using **Node.js** and **MongoDB**.
- Password encryption and validation.

---

### 🏠 Home Page
- Browse featured books on the landing screen.
- Categorize books by genre (e.g., **Fiction**, **Non-Fiction**, **Mystery**, etc.).
- **Search bar** to filter books by title, author, or genre.

---

### 📖 Book Details Page
- View complete information:
  - Title, author, price, rating, description, and cover image.
- Add books to the **shopping cart** with one click.

---

### 🛒 Shopping Cart
- View selected books.
- Modify quantities or remove books.
- **Total price** calculation and **discounts** applied.
- Checkout button to proceed to payment.

---

### 💳 Payment Integration
- Integrated with **Stripe** or **PayPal** for secure transactions.
- Display **order summary** and **payment confirmation** after checkout.

---

### 👤 User Profile
- Edit personal info: **name, email, and address**.
- View **order history** and past **reviews**.

---

### 🌟 Book Reviews & Ratings
- Users can write reviews and rate books.
- Display **average rating** on each book’s details page.

---

### 🔔 Push Notifications
- Notify users about:
  - New arrivals
  - Special offers/discounts
  - Order status updates

---

## ✅ Development Checklist

- [x] BLoC state management system
- [x] Clean Architecture for scalable codebase
- [x] Flutter Toast notifications
- [x] HTTP integration for backend APIs
- [x] Unit, Widget, and Integration Testing

---

## 🛠️ Tech Stack

### Frontend (Mobile)
- **Flutter**
- **Dart**
- **BLoC pattern**
- **Provider** (optional for simple state)

### Backend
- **Node.js**
- **Express**
- **MongoDB (Mongoose)**
- **JWT** for authentication
- **Stripe/PayPal SDKs**

---

## 📦 Setup Instructions

### 🔧 Backend

```bash
cd backend
npm install
npm start
