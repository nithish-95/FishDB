from pydantic import BaseModel


class Fish(BaseModel):
    common_name: str
    species: str
    family: str
    order: str
    fish_class: str
    
    class Config:
        from_attributes = True