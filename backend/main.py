from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import customers, tourpackages, tourguides, locations, hotels, bookings, payments, reviews, analytics

app = FastAPI(
    title="Tour Management System API",
    description="API for Tour Management System DBMS Project",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(customers.router, prefix="/api/customers", tags=["Customers"])
app.include_router(tourpackages.router, prefix="/api/tourpackages", tags=["Tour Packages"])
app.include_router(tourguides.router, prefix="/api/tourguides", tags=["Tour Guides"])
app.include_router(locations.router, prefix="/api/locations", tags=["Locations"])
app.include_router(hotels.router, prefix="/api/hotels", tags=["Hotels"])
app.include_router(bookings.router, prefix="/api/bookings", tags=["Bookings"])
app.include_router(payments.router, prefix="/api/payments", tags=["Payments"])
app.include_router(reviews.router, prefix="/api/reviews", tags=["Reviews"])
app.include_router(analytics.router, prefix="/api/analytics", tags=["Analytics"])

@app.get("/")
def root():
    return {"message": "Tour Management System API is running"}

@app.get("/health")
def health():
    return {"status": "ok"}
