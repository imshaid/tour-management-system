from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional, List
from database import execute_query

router = APIRouter()

class TravelerDetail(BaseModel):
    TravelerFirstName: str
    TravelerLastName: str
    TravelerAge: Optional[int] = None
    Gender: Optional[str] = None
    NID: Optional[str] = None

class BookingCreate(BaseModel):
    CustomerID: int
    TourID: int
    BookingDate: str
    BookingStatus: Optional[str] = "Pending"
    NoOfPeople: int
    Travelers: Optional[List[TravelerDetail]] = []

class BookingUpdate(BaseModel):
    BookingStatus: Optional[str] = None
    NoOfPeople: Optional[int] = None

@router.get("")
def get_bookings(search: str = "", status: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    base = """SELECT b.*, CONCAT(c.FirstName,' ',c.LastName) as CustomerName, c.Email,
                     t.TourName, t.Price, t.StartDate, t.EndDate
              FROM booking b
              LEFT JOIN customer c ON b.CustomerID=c.CustomerID
              LEFT JOIN tourpackage t ON b.TourID=t.TourID"""
    conditions = []
    params = []
    if search:
        conditions.append("(c.FirstName LIKE %s OR c.LastName LIKE %s OR t.TourName LIKE %s)")
        params += [f"%{search}%", f"%{search}%", f"%{search}%"]
    if status:
        conditions.append("b.BookingStatus=%s")
        params.append(status)
    where = (" WHERE " + " AND ".join(conditions)) if conditions else ""
    rows = execute_query(base + where + " ORDER BY b.BookingDate DESC LIMIT %s OFFSET %s", params + [limit, offset])
    count_q = "SELECT COUNT(*) as total FROM booking b LEFT JOIN customer c ON b.CustomerID=c.CustomerID LEFT JOIN tourpackage t ON b.TourID=t.TourID" + where
    count = execute_query(count_q, params)
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/{booking_id}")
def get_booking(booking_id: int):
    rows = execute_query(
        """SELECT b.*, CONCAT(c.FirstName,' ',c.LastName) as CustomerName, c.Email,
                  t.TourName, t.Price, t.StartDate, t.EndDate,
                  l.PlaceName, h.HotelName
           FROM booking b
           LEFT JOIN customer c ON b.CustomerID=c.CustomerID
           LEFT JOIN tourpackage t ON b.TourID=t.TourID
           LEFT JOIN location l ON t.LocationID=l.LocationID
           LEFT JOIN hotel h ON t.HotelID=h.HotelID
           WHERE b.BookingID=%s""", (booking_id,)
    )
    if not rows:
        raise HTTPException(status_code=404, detail="Booking not found")
    booking = rows[0]
    booking["travelers"] = execute_query("SELECT * FROM bookingdetail WHERE BookingID=%s", (booking_id,))
    return booking

@router.post("", status_code=201)
def create_booking(booking: BookingCreate):
    result = execute_query(
        "INSERT INTO booking (CustomerID,TourID,BookingDate,BookingStatus,NoOfPeople) VALUES (%s,%s,%s,%s,%s)",
        (booking.CustomerID, booking.TourID, booking.BookingDate, booking.BookingStatus, booking.NoOfPeople),
        fetch=False
    )
    new_id = result["last_insert_id"]
    for i, t in enumerate(booking.Travelers, 1):
        execute_query(
            "INSERT INTO bookingdetail (BookingID,DetailID,TravelerFirstName,TravelerLastName,TravelerAge,Gender,NID) VALUES (%s,%s,%s,%s,%s,%s,%s)",
            (new_id, i, t.TravelerFirstName, t.TravelerLastName, t.TravelerAge, t.Gender, t.NID),
            fetch=False
        )
    return {"message": "Booking created", "BookingID": new_id}

@router.put("/{booking_id}")
def update_booking(booking_id: int, booking: BookingUpdate):
    fields = {k: v for k, v in booking.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [booking_id]
    execute_query(f"UPDATE booking SET {set_clause} WHERE BookingID=%s", values, fetch=False)
    return {"message": "Booking updated"}

@router.delete("/{booking_id}")
def delete_booking(booking_id: int):
    execute_query("DELETE FROM bookingdetail WHERE BookingID=%s", (booking_id,), fetch=False)
    execute_query("DELETE FROM payment WHERE BookingID=%s", (booking_id,), fetch=False)
    execute_query("DELETE FROM booking WHERE BookingID=%s", (booking_id,), fetch=False)
    return {"message": "Booking deleted"}
