from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr
from typing import Optional
from database import execute_query

router = APIRouter()

class CustomerCreate(BaseModel):
    FirstName: str
    LastName: str
    Email: str
    NID: Optional[str] = None
    Gender: Optional[str] = None
    DoB: Optional[str] = None
    HouseNo: Optional[str] = None
    Area: Optional[str] = None
    City: Optional[str] = None
    District: Optional[str] = None
    PostalCode: Optional[str] = None
    PhoneNumbers: Optional[list[str]] = []

class CustomerUpdate(BaseModel):
    FirstName: Optional[str] = None
    LastName: Optional[str] = None
    Email: Optional[str] = None
    NID: Optional[str] = None
    Gender: Optional[str] = None
    DoB: Optional[str] = None
    HouseNo: Optional[str] = None
    Area: Optional[str] = None
    City: Optional[str] = None
    District: Optional[str] = None
    PostalCode: Optional[str] = None

@router.get("")
def get_customers(search: str = "", page: int = 1, limit: int = 10):
    offset = (page - 1) * limit
    if search:
        rows = execute_query(
            """SELECT c.*, GROUP_CONCAT(cp.PhoneNumber) as PhoneNumbers
               FROM customer c LEFT JOIN customerphone cp ON c.CustomerID=cp.CustomerID
               WHERE c.FirstName LIKE %s OR c.LastName LIKE %s OR c.Email LIKE %s OR c.City LIKE %s
               GROUP BY c.CustomerID ORDER BY c.CustomerID DESC LIMIT %s OFFSET %s""",
            (f"%{search}%", f"%{search}%", f"%{search}%", f"%{search}%", limit, offset)
        )
        count = execute_query(
            "SELECT COUNT(*) as total FROM customer WHERE FirstName LIKE %s OR LastName LIKE %s OR Email LIKE %s OR City LIKE %s",
            (f"%{search}%", f"%{search}%", f"%{search}%", f"%{search}%")
        )
    else:
        rows = execute_query(
            """SELECT c.*, GROUP_CONCAT(cp.PhoneNumber) as PhoneNumbers
               FROM customer c LEFT JOIN customerphone cp ON c.CustomerID=cp.CustomerID
               GROUP BY c.CustomerID ORDER BY c.CustomerID DESC LIMIT %s OFFSET %s""",
            (limit, offset)
        )
        count = execute_query("SELECT COUNT(*) as total FROM customer")
    return {"data": rows, "total": count[0]["total"], "page": page, "limit": limit}

@router.get("/{customer_id}")
def get_customer(customer_id: int):
    rows = execute_query(
        """SELECT c.*, GROUP_CONCAT(cp.PhoneNumber) as PhoneNumbers
           FROM customer c LEFT JOIN customerphone cp ON c.CustomerID=cp.CustomerID
           WHERE c.CustomerID=%s GROUP BY c.CustomerID""",
        (customer_id,)
    )
    if not rows:
        raise HTTPException(status_code=404, detail="Customer not found")
    return rows[0]

@router.post("", status_code=201)
def create_customer(customer: CustomerCreate):
    result = execute_query(
        """INSERT INTO customer (FirstName, LastName, Email, NID, Gender, DoB, RegDate, HouseNo, Area, City, District, PostalCode)
           VALUES (%s,%s,%s,%s,%s,%s,NOW(),%s,%s,%s,%s,%s)""",
        (customer.FirstName, customer.LastName, customer.Email, customer.NID,
         customer.Gender, customer.DoB, customer.HouseNo, customer.Area,
         customer.City, customer.District, customer.PostalCode),
        fetch=False
    )
    new_id = result["last_insert_id"]
    for phone in customer.PhoneNumbers:
        if phone:
            execute_query("INSERT INTO customerphone (CustomerID, PhoneNumber) VALUES (%s,%s)",
                          (new_id, phone), fetch=False)
    return {"message": "Customer created", "CustomerID": new_id}

@router.put("/{customer_id}")
def update_customer(customer_id: int, customer: CustomerUpdate):
    fields = {k: v for k, v in customer.dict().items() if v is not None}
    if not fields:
        raise HTTPException(status_code=400, detail="No fields to update")
    set_clause = ", ".join(f"{k}=%s" for k in fields)
    values = list(fields.values()) + [customer_id]
    execute_query(f"UPDATE customer SET {set_clause} WHERE CustomerID=%s", values, fetch=False)
    return {"message": "Customer updated"}

@router.delete("/{customer_id}")
def delete_customer(customer_id: int):
    execute_query("DELETE FROM customerphone WHERE CustomerID=%s", (customer_id,), fetch=False)
    execute_query("DELETE FROM customer WHERE CustomerID=%s", (customer_id,), fetch=False)
    return {"message": "Customer deleted"}

@router.get("/{customer_id}/bookings")
def get_customer_bookings(customer_id: int):
    return execute_query(
        """SELECT b.*, t.TourName, t.Price FROM booking b
           JOIN tourpackage t ON b.TourID=t.TourID
           WHERE b.CustomerID=%s ORDER BY b.BookingDate DESC""",
        (customer_id,)
    )
