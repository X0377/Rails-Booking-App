# 🏨 Lodging Booking App

## 🔍 Overview
The **Lodging Reservation App** is a web application built with **Ruby on Rails**, designed to match users who want to rent out accommodations with those looking to book stays. This project serves as a comprehensive challenge, integrating various **Rails functionalities**, authentication, and search features.

## 🚀 Features
### 📄 User Management
- **User authentication** using `devise` (sign up, login, logout)
- **Profile management** (edit name, email, password, and profile picture)
- **Conditional UI** (shows login/register for guests, user dropdown for logged-in users)

### 🏨 Accommodation Management
- **CRUD functionality** for `Room` (create, view, update, delete accommodations)
- **Image uploads** using Active Storage
- **Accommodation search**
  - **By area**: Tokyo, Osaka, Kyoto, Sapporo (fuzzy search by address)
  - **By keyword**: Searches facility name & details
- **Facility details page** with back navigation

### 👤 Booking & Reservation
- **Booking functionality** (`Reservation` model)
- **Booking validation**
  - Check-in date **must be today or later**
  - Check-out date **must be after check-in**
  - Number of guests **must be 1 or more**
- **Reservation confirmation page** displaying:
  - Check-in & Check-out dates
  - Total stay duration
  - Number of guests
  - Total price calculation
- **Reservation list** (user's booked stays)
- **Reservation deletion with confirmation modal**

### ⚠️ UX Improvements & Error Handling
- **Flash messages** for success/error feedback
- **Validation messages** (ensure correct user inputs)
- **Formatted date display**: `YYYY/MM/DD HH:MM`
- **Default images** for rooms & user profiles if none are uploaded

## 🌟 Implementation Progress
✅ **User authentication & routing setup**
✅ **User profile settings & edit functionality**
✅ **Room model & controller (basic CRUD implementation)**
✅ **Facility registration, listing, and details page**
✅ **CRUD improvements & Active Storage image upload integration**
✅ **User profile icon upload feature**

🔄 **Next Steps:**
- **Implement accommodation search** (area & keyword-based)
- **Develop reservation system (CRUD for bookings)**
- **Create reservation confirmation & list pages**
- **Improve validation for pricing, dates, and guest count**
- **Add confirmation modals for deletions** (facilities & reservations)

## 🛠 Technologies Used
- **Ruby on Rails** 6.1.3.2
- **Devise** (authentication)
- **Active Storage** (image upload)
- **SQLite** (database)
- **Bootstrap** (UI styling)
- **ERB templates** (view rendering)

## 📚 Setup
To run this project locally, follow these steps:

```sh
git clone <repository-url>
cd lodging_reservation_app
bundle install
rails db:create db:migrate
rails s
```
Then, open `http://localhost:3000` in your browser.

## 🔮 Future Improvements
- **Search filtering enhancements** (sorting by price, availability, etc.)
- **Payment gateway integration**
- **Admin panel for managing users & accommodations**
- **Responsive UI improvements**

## ⚖️ License
This project is licensed under the MIT License.

