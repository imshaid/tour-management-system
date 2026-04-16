from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database import execute_query

router = APIRouter()

class GuideCreate(BaseModel):
    FirstName: str
    LastName: str
    Phone: str
    ExperienceYears: Optional[int] = None
    Languages: Optional[list[str]] = []

class GuideUpdate(BaseModel):
    FirstName: Optional[str] = None
    LastName: Optional[str] = None
    Phone: Optional[str] = None
    ExperienceYears: Optional[int] = None

@router.get("")
def get_guides(search: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    base = """SELECT g.*, GROUP_CONCAT(gl.Language ORDER BY gl.Language) as Languages
              FROM tourguide g LEFT JOIN guidelanguage gl ON g.GuideID=gl.GuideID"""
    if search:
        rows = execute_query(base + " WHERE g.FirstName LIKE %s OR g.LastName LIKE %s OR g.Phone LIKE %s GROUP BY g.GuideID ORDER BY g.GuideID DESC LIMIT %s OFFSET %s",
                             (f"%{search}%", f"%{search}%", f"%{search}%", limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM tourguide WHERE FirstName LIKE %s OR LastName LIKE %s OR Phone LIKE %s",
                              (f"%{search}%", f"%{search}%", f"%{search}%"))
    else:
        rows = execute_query(base + " GROUP BY g.GuideID ORDER BY g.GuideID DESC LIMIT %s OFFSET %s", (limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM tourguide")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/{guide_id}")
def get_guide(guide_id: int):
    rows = execute_query(
        """SELECT g.*, GROUP_CONCAT(gl.Language ORDER BY gl.Language) as Languages
           FROM tourguide g LEFT JOIN guidelanguage gl ON g.GuideID=gl.GuideID
           WHERE g.GuideID=%s GROUP BY g.GuideID""", (guide_id,)
    )
    if not rows:
        raise HTTPException(status_code=404, detail="Guide not found")
    return rows[0]

@router.post("", status_code=201)
def create_guide(guide: GuideCreate):
    result = execute_query(
        "INSERT INTO tourguide (FirstName,LastName,Phone,ExperienceYears) VALUES (%s,%s,%s,%s)",
        (guide.FirstName, guide.LastName, guide.Phone, guide.ExperienceYears),
        fetch=False
    )
    new_id = result["last_insert_id"]
    for lang in guide.Languages:
        if lang:
            execute_query("INSERT INTO guidelanguage (GuideID, Language) VALUES (%s,%s)", (new_id, lang), fetch=False)
    return {"message": "Guide created", "GuideID": new_id}

@router.put("/{guide_id}")
def update_guide(guide_id: int, guide: GuideUpdate):
    fields = {k: v for k, v in guide.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [guide_id]
    execute_query(f"UPDATE tourguide SET {set_clause} WHERE GuideID=%s", values, fetch=False)
    return {"message": "Guide updated"}

@router.delete("/{guide_id}")
def delete_guide(guide_id: int):
    execute_query("DELETE FROM guidelanguage WHERE GuideID=%s", (guide_id,), fetch=False)
    execute_query("DELETE FROM tourguide WHERE GuideID=%s", (guide_id,), fetch=False)
    return {"message": "Guide deleted"}
