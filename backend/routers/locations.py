from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database import execute_query

router = APIRouter()

class LocationCreate(BaseModel):
    PlaceName: str
    Area: Optional[str] = None
    District: Optional[str] = None
    Division: Optional[str] = None
    BestSeason: Optional[str] = None
    Description: Optional[str] = None

class LocationUpdate(BaseModel):
    PlaceName: Optional[str] = None
    Area: Optional[str] = None
    District: Optional[str] = None
    Division: Optional[str] = None
    BestSeason: Optional[str] = None
    Description: Optional[str] = None

@router.get("")
def get_locations(search: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    if search:
        rows = execute_query(
            "SELECT * FROM location WHERE PlaceName LIKE %s OR District LIKE %s OR Division LIKE %s ORDER BY LocationID DESC LIMIT %s OFFSET %s",
            (f"%{search}%", f"%{search}%", f"%{search}%", limit, offset)
        )
        count = execute_query("SELECT COUNT(*) as total FROM location WHERE PlaceName LIKE %s OR District LIKE %s OR Division LIKE %s",
                              (f"%{search}%", f"%{search}%", f"%{search}%"))
    else:
        rows = execute_query("SELECT * FROM location ORDER BY LocationID DESC LIMIT %s OFFSET %s", (limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM location")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/all")
def get_all_locations():
    return execute_query("SELECT LocationID, PlaceName, District FROM location ORDER BY PlaceName")

@router.get("/{location_id}")
def get_location(location_id: int):
    rows = execute_query("SELECT * FROM location WHERE LocationID=%s", (location_id,))
    if not rows:
        raise HTTPException(status_code=404, detail="Location not found")
    return rows[0]

@router.post("", status_code=201)
def create_location(location: LocationCreate):
    result = execute_query(
        "INSERT INTO location (PlaceName,Area,District,Division,BestSeason,Description) VALUES (%s,%s,%s,%s,%s,%s)",
        (location.PlaceName, location.Area, location.District, location.Division, location.BestSeason, location.Description),
        fetch=False
    )
    return {"message": "Location created", "LocationID": result["last_insert_id"]}

@router.put("/{location_id}")
def update_location(location_id: int, location: LocationUpdate):
    fields = {k: v for k, v in location.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [location_id]
    execute_query(f"UPDATE location SET {set_clause} WHERE LocationID=%s", values, fetch=False)
    return {"message": "Location updated"}

@router.delete("/{location_id}")
def delete_location(location_id: int):
    execute_query("DELETE FROM location WHERE LocationID=%s", (location_id,), fetch=False)
    return {"message": "Location deleted"}
