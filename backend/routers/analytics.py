from fastapi import APIRouter
from database import execute_query

router = APIRouter()

@router.get("/dashboard")
def get_dashboard():
    total_customers = execute_query("SELECT COUNT(*) as count FROM customer")[0]["count"]
    total_tours = execute_query("SELECT COUNT(*) as count FROM tourpackage")[0]["count"]
    total_bookings = execute_query("SELECT COUNT(*) as count FROM booking")[0]["count"]
    total_revenue = execute_query("SELECT COALESCE(SUM(Amount),0) as total FROM payment WHERE PaymentStatus='Paid'")[0]["total"]
    pending_payments = execute_query("SELECT COUNT(*) as count FROM payment WHERE PaymentStatus='Pending'")[0]["count"]
    avg_rating = execute_query("SELECT ROUND(AVG(Rating),1) as avg FROM review")[0]["avg"]
    recent_bookings = execute_query(
        """SELECT b.BookingID, CONCAT(c.FirstName,' ',c.LastName) as CustomerName,
                  t.TourName, b.BookingDate, b.BookingStatus, b.NoOfPeople
           FROM booking b
           LEFT JOIN customer c ON b.CustomerID=c.CustomerID
           LEFT JOIN tourpackage t ON b.TourID=t.TourID
           ORDER BY b.BookingDate DESC LIMIT 5"""
    )
    booking_by_status = execute_query(
        "SELECT BookingStatus, COUNT(*) as count FROM booking GROUP BY BookingStatus"
    )
    revenue_by_method = execute_query(
        "SELECT PaymentMethod, SUM(Amount) as total FROM payment WHERE PaymentStatus='Paid' GROUP BY PaymentMethod ORDER BY total DESC"
    )
    top_tours = execute_query(
        """SELECT t.TourName, COUNT(b.BookingID) as bookings, COALESCE(AVG(r.Rating),0) as avg_rating
           FROM tourpackage t
           LEFT JOIN booking b ON t.TourID=b.TourID
           LEFT JOIN review r ON t.TourID=r.TourID
           GROUP BY t.TourID, t.TourName
           ORDER BY bookings DESC LIMIT 5"""
    )
    return {
        "stats": {
            "total_customers": total_customers,
            "total_tours": total_tours,
            "total_bookings": total_bookings,
            "total_revenue": float(total_revenue) if total_revenue else 0,
            "pending_payments": pending_payments,
            "avg_rating": float(avg_rating) if avg_rating else 0,
        },
        "recent_bookings": recent_bookings,
        "booking_by_status": booking_by_status,
        "revenue_by_method": revenue_by_method,
        "top_tours": top_tours,
    }

@router.get("/top-tours")
def top_tours_by_bookings():
    return execute_query(
        """SELECT t.TourName, t.Price, l.PlaceName,
                  COUNT(b.BookingID) as total_bookings,
                  SUM(b.NoOfPeople) as total_travelers,
                  ROUND(AVG(r.Rating), 1) as avg_rating
           FROM tourpackage t
           LEFT JOIN booking b ON t.TourID=b.TourID
           LEFT JOIN location l ON t.LocationID=l.LocationID
           LEFT JOIN review r ON t.TourID=r.TourID
           GROUP BY t.TourID, t.TourName, t.Price, l.PlaceName
           ORDER BY total_bookings DESC LIMIT 10"""
    )

@router.get("/revenue-by-tour")
def revenue_by_tour():
    return execute_query(
        """SELECT t.TourName, SUM(p.Amount) as total_revenue, COUNT(p.PaymentID) as payments
           FROM payment p
           JOIN booking b ON p.BookingID=b.BookingID
           JOIN tourpackage t ON b.TourID=t.TourID
           WHERE p.PaymentStatus='Paid'
           GROUP BY t.TourID, t.TourName
           ORDER BY total_revenue DESC LIMIT 10"""
    )

@router.get("/guide-performance")
def guide_performance():
    return execute_query(
        """SELECT CONCAT(g.FirstName,' ',g.LastName) as GuideName, g.ExperienceYears,
                  COUNT(DISTINCT t.TourID) as total_tours,
                  COUNT(DISTINCT b.BookingID) as total_bookings,
                  ROUND(AVG(r.Rating), 1) as avg_rating
           FROM tourguide g
           LEFT JOIN tourpackage t ON g.GuideID=t.GuideID
           LEFT JOIN booking b ON t.TourID=b.TourID
           LEFT JOIN review r ON t.TourID=r.TourID
           GROUP BY g.GuideID
           ORDER BY avg_rating DESC, total_bookings DESC LIMIT 10"""
    )

@router.get("/location-popularity")
def location_popularity():
    return execute_query(
        """SELECT l.PlaceName, l.Division, l.BestSeason,
                  COUNT(DISTINCT t.TourID) as tour_packages,
                  COUNT(b.BookingID) as total_bookings
           FROM location l
           LEFT JOIN tourpackage t ON l.LocationID=t.LocationID
           LEFT JOIN booking b ON t.TourID=b.TourID
           GROUP BY l.LocationID, l.PlaceName, l.Division, l.BestSeason
           ORDER BY total_bookings DESC"""
    )

@router.get("/monthly-bookings")
def monthly_bookings():
    return execute_query(
        """SELECT DATE_FORMAT(BookingDate, '%Y-%m') as month,
                  COUNT(*) as bookings,
                  SUM(NoOfPeople) as travelers
           FROM booking
           GROUP BY month
           ORDER BY month DESC LIMIT 12"""
    )
