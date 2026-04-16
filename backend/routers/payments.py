from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database import execute_query

router = APIRouter()

class PaymentCreate(BaseModel):
    BookingID: int
    Amount: float
    PaymentMethod: str
    PaymentStatus: Optional[str] = "Pending"
    PaymentDate: str
    TransactionID: Optional[str] = None

class PaymentUpdate(BaseModel):
    Amount: Optional[float] = None
    PaymentMethod: Optional[str] = None
    PaymentStatus: Optional[str] = None
    PaymentDate: Optional[str] = None
    TransactionID: Optional[str] = None

@router.get("")
def get_payments(status: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    base = """SELECT p.*, b.CustomerID, b.TourID,
                     CONCAT(c.FirstName,' ',c.LastName) as CustomerName,
                     t.TourName
              FROM payment p
              LEFT JOIN booking b ON p.BookingID=b.BookingID
              LEFT JOIN customer c ON b.CustomerID=c.CustomerID
              LEFT JOIN tourpackage t ON b.TourID=t.TourID"""
    if status:
        rows = execute_query(base + " WHERE p.PaymentStatus=%s ORDER BY p.PaymentDate DESC LIMIT %s OFFSET %s", (status, limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM payment WHERE PaymentStatus=%s", (status,))
    else:
        rows = execute_query(base + " ORDER BY p.PaymentDate DESC LIMIT %s OFFSET %s", (limit, offset))
        count = execute_query("SELECT COUNT(*) as total FROM payment")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/{payment_id}")
def get_payment(payment_id: int):
    rows = execute_query(
        """SELECT p.*, CONCAT(c.FirstName,' ',c.LastName) as CustomerName, t.TourName
           FROM payment p
           LEFT JOIN booking b ON p.BookingID=b.BookingID
           LEFT JOIN customer c ON b.CustomerID=c.CustomerID
           LEFT JOIN tourpackage t ON b.TourID=t.TourID
           WHERE p.PaymentID=%s""", (payment_id,)
    )
    if not rows:
        raise HTTPException(status_code=404, detail="Payment not found")
    return rows[0]

@router.post("", status_code=201)
def create_payment(payment: PaymentCreate):
    result = execute_query(
        "INSERT INTO payment (BookingID,Amount,PaymentMethod,PaymentStatus,PaymentDate,TransactionID) VALUES (%s,%s,%s,%s,%s,%s)",
        (payment.BookingID, payment.Amount, payment.PaymentMethod, payment.PaymentStatus, payment.PaymentDate, payment.TransactionID),
        fetch=False
    )
    return {"message": "Payment created", "PaymentID": result["last_insert_id"]}

@router.put("/{payment_id}")
def update_payment(payment_id: int, payment: PaymentUpdate):
    fields = {k: v for k, v in payment.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [payment_id]
    execute_query(f"UPDATE payment SET {set_clause} WHERE PaymentID=%s", values, fetch=False)
    return {"message": "Payment updated"}

@router.delete("/{payment_id}")
def delete_payment(payment_id: int):
    execute_query("DELETE FROM payment WHERE PaymentID=%s", (payment_id,), fetch=False)
    return {"message": "Payment deleted"}
