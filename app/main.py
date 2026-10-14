import os

from fastapi import FastAPI, Depends
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import declarative_base, sessionmaker, Session

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://cloudlaunch:cloudlaunchpass@localhost:5432/cloudlaunch"
)

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

Base = declarative_base()


class Item(Base):
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)


Base.metadata.create_all(bind=engine)


app = FastAPI(
    title="CloudLaunch API",
    description="CloudLaunch DevOps portfolio application",
    version="1.0.0"
)


def get_db():
    db = SessionLocal()

    try:
        yield db
    finally:
        db.close()


@app.get("/")
def root():
    return {
        "message": "CloudLaunch API is running"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }


@app.get("/ready")
def ready():
    return {
        "status": "ready"
    }


@app.get("/api/items")
def get_items(db: Session = Depends(get_db)):
    items = db.query(Item).all()

    return {
        "items": [
            {
                "id": item.id,
                "name": item.name
            }
            for item in items
        ]
    }


@app.post("/api/items")
def create_item(name: str, db: Session = Depends(get_db)):
    item = Item(name=name)

    db.add(item)
    db.commit()
    db.refresh(item)

    return {
        "id": item.id,
        "name": item.name
    }
