from typing import List
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

import json

from FishModule.schemas import FishList, FishListClass, FishListCommonName, FishListFamily, FishListOrder, FishListSpecies
from FishModule.models import Fish

router = APIRouter()

def load_fish_data() -> List[Fish]:
    with open("data.json", "r") as f:
        raw_data = json.load(f)
    return raw_data
    # return [Fish(**item) for item in raw_data]


@router.get("/fish_list")
async def get_all_fishes():
    # fishes = load_fish_data()
    # return {"fishes": fishes}
    with open("data.json", "r") as f:
        raw_data = json.load(f)
    return raw_data


@router.get("/fish_list/family/{family}", response_model=FishListFamily)
async def get_fishes_by_family(family: str):
    fishes = [fish for fish in load_fish_data() if fish.family.lower() == family.lower()]
    if not fishes:
        raise HTTPException(status_code=404, detail="No fishes found for this family")
    return {"family": family, "fishes": fishes}


@router.get("/fish_list/species/{species}", response_model=FishListSpecies)
async def get_fishes_by_species(species: str):
    fishes = [fish for fish in load_fish_data() if fish.species.lower() == species.lower()]
    if not fishes:
        raise HTTPException(status_code=404, detail="No fishes found for this species")
    return {"species": species, "fishes": fishes}


@router.get("/fish_list/class/{fish_class}", response_model=FishListClass)
async def get_fishes_by_class(fish_class: str):
    fishes = [fish for fish in load_fish_data() if fish.fish_class.lower() == fish_class.lower()]
    if not fishes:
        raise HTTPException(status_code=404, detail="No fishes found for this class")
    return {"fish_class": fish_class, "fishes": fishes}


@router.get("/fish_list/order/{order}", response_model=FishListOrder)
async def get_fishes_by_order(order: str):
    fishes = [fish for fish in load_fish_data() if fish.order.lower() == order.lower()]
    if not fishes:
        raise HTTPException(status_code=404, detail="No fishes found for this order")
    return {"order": order, "fishes": fishes}


@router.get("/fish_list/common_name/{common_name}", response_model=FishListCommonName)
async def get_fishes_by_common_name(common_name: str):
    fishes = [fish for fish in load_fish_data() if fish.common_name.lower() == common_name.lower()]
    if not fishes:
        raise HTTPException(status_code=404, detail="No fishes found for this common name")
    return {"common_name": common_name, "fishes": fishes}
