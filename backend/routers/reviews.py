from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database import execute_query

router = APIRouter()

class ReviewCreate(BaseModel):
    CustomerID: int
    TourID: int
    Rating: int
    Comment: Optional[str] = None
    ReviewDate: str

class ReviewUpdate(BaseModel):
    Rating: Optional[int] = None
    Comment: Optional[str] = None
    ReviewDate: Optional[str] = None

@router.get("")
def get_reviews(page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    rows = execute_query(
        """SELECT r.*, CONCAT(c.FirstName,' ',c.LastName) as CustomerName, t.TourName
           FROM review r
           LEFT JOIN customer c ON r.CustomerID=c.CustomerID
           LEFT JOIN tourpackage t ON r.TourID=t.TourID
           ORDER BY r.ReviewDate DESC LIMIT %s OFFSET %s""", (limit, offset)
    )
    count = execute_query("SELECT COUNT(*) as total FROM review")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/{review_id}")
def get_review(review_id: int):
    rows = execute_query(
        """SELECT r.*, CONCAT(c.FirstName,' ',c.LastName) as CustomerName, t.TourName
           FROM review r
           LEFT JOIN customer c ON r.CustomerID=c.CustomerID
           LEFT JOIN tourpackage t ON r.TourID=t.TourID
           WHERE r.ReviewID=%s""", (review_id,)
    )
    if not rows:
        raise HTTPException(status_code=404, detail="Review not found")
    return rows[0]

@router.post("", status_code=201)
def create_review(review: ReviewCreate):
    result = execute_query(
        "INSERT INTO review (CustomerID,TourID,Rating,Comment,ReviewDate) VALUES (%s,%s,%s,%s,%s)",
        (review.CustomerID, review.TourID, review.Rating, review.Comment, review.ReviewDate),
        fetch=False
    )
    return {"message": "Review created", "ReviewID": result["last_insert_id"]}

@router.put("/{review_id}")
def update_review(review_id: int, review: ReviewUpdate):
    fields = {k: v for k, v in review.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [review_id]
    execute_query(f"UPDATE review SET {set_clause} WHERE ReviewID=%s", values, fetch=False)
    return {"message": "Review updated"}

@router.delete("/{review_id}")
def delete_review(review_id: int):
    execute_query("DELETE FROM review WHERE ReviewID=%s", (review_id,), fetch=False)
    return {"message": "Review deleted"}
