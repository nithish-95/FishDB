from typing import List
from pydantic import BaseModel

from .models import Fish
        
class FishList(BaseModel):
    fishes: List[Fish]

class FishListFamily(BaseModel):
    family: str
    fishes: List[Fish]

class FishListSpecies(BaseModel):
    species: str
    fishes: List[Fish]

class FishListClass(BaseModel):
    fish_class: str
    fishes: List[Fish]

class FishListOrder(BaseModel):
    order: str
    fishes: List[Fish]

class FishListCommonName(BaseModel):
    common_name: str
    fishes: List[Fish]