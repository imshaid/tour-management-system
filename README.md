# 🗺️ Tour Management System

A full-stack web application for managing tour packages, customers, bookings, payments, and reviews. Built with **FastAPI (Python)** backend, **Vanilla JS + Bootstrap** frontend, and **MySQL** (via XAMPP/phpMyAdmin).

---

## 📁 Project Structure

```
tour-management-system/
├── backend/                    # FastAPI Python backend
│   ├── main.py                 # App entry point & routes
│   ├── database.py             # DB connection
│   ├── requirements.txt        # Python dependencies
│   ├── .env.example            # Environment variables template
│   └── routers/
│       ├── customers.py
│       ├── tourpackages.py
│       ├── tourguides.py
│       ├── locations.py
│       ├── hotels.py
│       ├── bookings.py
│       ├── payments.py
│       ├── reviews.py
│       └── analytics.py
├── frontend/                   # HTML/CSS/JS frontend
│   ├── index.html              # Main SPA shell
│   └── assets/
│       ├── css/style.css       # All styles
│       └── js/
│           ├── utils.js        # API helpers, utils
│           └── pages/          # Page-specific JS
│               ├── dashboard.js
│               ├── customers.js
│               ├── tourpackages.js
│               ├── bookings.js
│               ├── payments.js  # Also includes reviews, guides, locations, hotels
│               └── analytics.js
├── database/
│   └── tourmanagementsystem.sql  # Full DB dump
├── .github/
│   └── workflows/
│       └── deploy.yml          # CI/CD (optional)
└── README.md
```

---

## 🚀 Running Locally

### Prerequisites
- **XAMPP** (Apache + MySQL) running
- **Python 3.10+** installed
- Database imported via phpMyAdmin

### Step 1 — Import the Database
1. Open `http://localhost/phpmyadmin`
2. Create database: `tourmanagementsystem`
3. Click **Import** → select `database/tourmanagementsystem.sql` → Go

### Step 2 — Setup Backend

```bash
cd backend

# Copy environment file
cp .env.example .env
# Edit .env if your MySQL password is not empty

# Create virtual environment (recommended)
python -m venv venv

# Activate (Windows)
venv\Scripts\activate
# Activate (Mac/Linux)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run the server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Backend will be live at: **http://localhost:8000**
API docs (Swagger): **http://localhost:8000/docs**

### Step 3 — Open Frontend

Simply open `frontend/index.html` in your browser, OR serve it with a local server:

```bash
# Using Python
cd frontend
python -m http.server 5500

# Then open: http://localhost:5500
```

> **Important:** The frontend connects to `http://localhost:8000/api` by default. If your backend runs on a different port, edit the `API_BASE` variable in `frontend/assets/js/utils.js`.

---

## 🌐 Deployment

### Backend → Render
1. Push to GitHub
2. Go to [render.com](https://render.com) → New Web Service
3. Connect your repo → Set root dir to `backend`
4. Build command: `pip install -r requirements.txt`
5. Start command: `uvicorn main:app --host 0.0.0.0 --port $PORT`
6. Add environment variables from `.env.example`

### Database → PlanetScale / Railway / Clever Cloud
- Railway and Clever Cloud offer free MySQL hosting
- Get your connection string and update the env vars on Render

### Frontend → Vercel / Netlify
1. Push `frontend/` folder to GitHub
2. Connect to Vercel/Netlify
3. Before deploying, update `API_BASE` in `utils.js` to your Render backend URL

---

## 📊 Features

| Feature | Description |
|--------|------------|
| **Dashboard** | Stats, charts, recent bookings |
| **Customers** | Full CRUD with phone numbers & address |
| **Tour Packages** | CRUD with location/guide/hotel relations |
| **Bookings** | CRUD with traveler detail management |
| **Payments** | CRUD with multiple payment methods |
| **Reviews** | CRUD with star ratings |
| **Tour Guides** | CRUD with multi-language support |
| **Locations** | CRUD with seasonal info |
| **Hotels** | CRUD with star ratings & location link |
| **Analytics** | Complex SQL queries visualized as charts |

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML5, CSS3, Bootstrap 5.3, Vanilla JS, Chart.js |
| Backend | Python 3.10+, FastAPI, Pydantic |
| Database | MySQL (MariaDB via XAMPP) |
| ORM | Raw SQL (mysql-connector-python) |
| API | RESTful JSON API |

---

## 📌 API Endpoints Summary

| Resource | Endpoints |
|---------|----------|
| Customers | `GET/POST /api/customers`, `GET/PUT/DELETE /api/customers/{id}` |
| Tours | `GET/POST /api/tourpackages`, `GET/PUT/DELETE /api/tourpackages/{id}` |
| Bookings | `GET/POST /api/bookings`, `GET/PUT/DELETE /api/bookings/{id}` |
| Payments | `GET/POST /api/payments`, `GET/PUT/DELETE /api/payments/{id}` |
| Reviews | `GET/POST /api/reviews`, `GET/PUT/DELETE /api/reviews/{id}` |
| Guides | `GET/POST /api/tourguides`, `GET/PUT/DELETE /api/tourguides/{id}` |
| Locations | `GET/POST /api/locations`, `GET/PUT/DELETE /api/locations/{id}` |
| Hotels | `GET/POST /api/hotels`, `GET/PUT/DELETE /api/hotels/{id}` |
| Analytics | `GET /api/analytics/dashboard`, `/top-tours`, `/revenue-by-tour`, `/guide-performance`, `/location-popularity`, `/monthly-bookings` |

Full interactive docs: `http://localhost:8000/docs`
