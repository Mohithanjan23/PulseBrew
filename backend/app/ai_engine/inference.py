from .energy_model import EnergyModel

model = EnergyModel()

def should_drink(bio):
    score = model.predict(bio)

    if score["energy"] < 40 and bio["heart_rate"] < 95:
        return True
    return False
