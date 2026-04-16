from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database import execute_query

router = APIRouter()

class TourPackageCreate(BaseModel):
    TourName: str
    StartDate: str
    EndDate: str
    Price: float
    MaxSeats: int
    LocationID: int
    GuideID: int
    HotelID: int

class TourPackageUpdate(BaseModel):
    TourName: Optional[str] = None
    StartDate: Optional[str] = None
    EndDate: Optional[str] = None
    Price: Optional[float] = None
    MaxSeats: Optional[int] = None
    LocationID: Optional[int] = None
    GuideID: Optional[int] = None
    HotelID: Optional[int] = None

@router.get("")
def get_tourpackages(search: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    base = """SELECT t.*, l.PlaceName, l.District, l.Division,
                     CONCAT(g.FirstName,' ',g.LastName) as GuideName,
                     h.HotelName,
                     (t.MaxSeats - COALESCE(
                       (SELECT SUM(NoOfPeople) FROM booking WHERE TourID=t.TourID AND BookingStatus='Confirmed'),0)
                     ) as AvailableSeats
              FROM tourpackage t
              LEFT JOIN location l ON t.LocationID=l.LocationID
              LEFT JOIN tourguide g ON t.GuideID=g.GuideID
              LEFT JOIN hotel h ON t.HotelID=h.HotelID"""
    if search:
        rows = execute_query(base + " WHERE t.TourName LIKE %s OR l.PlaceName LIKE %s OR l.District LIKE %s ORDER BY t.TourID DESC LIMIT %s OFFSET %s",
                             (f"%{search}%", f"%{search}%", f"%{search}%", limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM tourpackage t LEFT JOIN location l ON t.LocationID=l.LocationID WHERE t.TourName LIKE %s OR l.PlaceName LIKE %s OR l.District LIKE %s",
                              (f"%{search}%", f"%{search}%", f"%{search}%"))
    else:
        rows = execute_query(base + " ORDER BY t.TourID DESC LIMIT %s OFFSET %s", (limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM tourpackage")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/{tour_id}")
def get_tourpackage(tour_id: int):
    rows = execute_query(
        """SELECT t.*, l.PlaceName, l.District, l.Division, l.BestSeason, l.Description as LocationDesc,
                  CONCAT(g.FirstName,' ',g.LastName) as GuideName, g.Phone as GuidePhone,
                  h.HotelName, h.StarRating,
                  (t.MaxSeats - COALESCE(
                    (SELECT SUM(NoOfPeople) FROM booking WHERE TourID=t.TourID AND BookingStatus='Confirmed'),0)
                  ) as AvailableSeats
           FROM tourpackage t
           LEFT JOIN location l ON t.LocationID=l.LocationID
           LEFT JOIN tourguide g ON t.GuideID=g.GuideID
           LEFT JOIN hotel h ON t.HotelID=h.HotelID
           WHERE t.TourID=%s""", (tour_id,)
    )
    if not rows:
        raise HTTPException(status_code=404, detail="Tour package not found")
    return rows[0]

@router.post("", status_code=201)
def create_tourpackage(tour: TourPackageCreate):
    result = execute_query(
        "INSERT INTO tourpackage (TourName,StartDate,EndDate,Price,MaxSeats,LocationID,GuideID,HotelID) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
        (tour.TourName, tour.StartDate, tour.EndDate, tour.Price, tour.MaxSeats, tour.LocationID, tour.GuideID, tour.HotelID),
        fetch=False
    )
    return {"message": "Tour package created", "TourID": result["last_insert_id"]}

@router.put("/{tour_id}")
def update_tourpackage(tour_id: int, tour: TourPackageUpdate):
    fields = {k: v for k, v in tour.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [tour_id]
    execute_query(f"UPDATE tourpackage SET {set_clause} WHERE TourID=%s", values, fetch=False)
    return {"message": "Tour package updated"}

@router.delete("/{tour_id}")
def delete_tourpackage(tour_id: int):
    execute_query("DELETE FROM tourpackage WHERE TourID=%s", (tour_id,), fetch=False)
    return {"message": "Tour package deleted"}
