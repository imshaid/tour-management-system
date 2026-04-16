from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database import execute_query

router = APIRouter()

class HotelCreate(BaseModel):
    HotelName: str
    StarRating: Optional[int] = None
    PricePerNight: Optional[float] = None
    LocationID: int

class HotelUpdate(BaseModel):
    HotelName: Optional[str] = None
    StarRating: Optional[int] = None
    PricePerNight: Optional[float] = None
    LocationID: Optional[int] = None

@router.get("")
def get_hotels(search: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    base = "SELECT h.*, l.PlaceName, l.District FROM hotel h LEFT JOIN location l ON h.LocationID=l.LocationID"
    if search:
        rows = execute_query(base + " WHERE h.HotelName LIKE %s OR l.PlaceName LIKE %s OR l.District LIKE %s ORDER BY h.HotelID DESC LIMIT %s OFFSET %s",
                             (f"%{search}%", f"%{search}%", f"%{search}%", limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM hotel h LEFT JOIN location l ON h.LocationID=l.LocationID WHERE h.HotelName LIKE %s OR l.PlaceName LIKE %s OR l.District LIKE %s",
                              (f"%{search}%", f"%{search}%", f"%{search}%"))
    else:
        rows = execute_query(base + " ORDER BY h.HotelID DESC LIMIT %s OFFSET %s", (limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM hotel")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/all")
def get_all_hotels():
    return execute_query("SELECT HotelID, HotelName, StarRating FROM hotel ORDER BY HotelName")

@router.get("/{hotel_id}")
def get_hotel(hotel_id: int):
    rows = execute_query("SELECT h.*, l.PlaceName, l.District FROM hotel h LEFT JOIN location l ON h.LocationID=l.LocationID WHERE h.HotelID=%s", (hotel_id,))
    if not rows:
        raise HTTPException(status_code=404, detail="Hotel not found")
    return rows[0]

@router.post("", status_code=201)
def create_hotel(hotel: HotelCreate):
    result = execute_query(
        "INSERT INTO hotel (HotelName,StarRating,PricePerNight,LocationID) VALUES (%s,%s,%s,%s)",
        (hotel.HotelName, hotel.StarRating, hotel.PricePerNight, hotel.LocationID),
        fetch=False
    )
    return {"message": "Hotel created", "HotelID": result["last_insert_id"]}

@router.put("/{hotel_id}")
def update_hotel(hotel_id: int, hotel: HotelUpdate):
    fields = {k: v for k, v in hotel.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [hotel_id]
    execute_query(f"UPDATE hotel SET {set_clause} WHERE HotelID=%s", values, fetch=False)
    return {"message": "Hotel updated"}

@router.delete("/{hotel_id}")
def delete_hotel(hotel_id: int):
    execute_query("DELETE FROM hotel WHERE HotelID=%s", (hotel_id,), fetch=False)
    return {"message": "Hotel deleted"}
