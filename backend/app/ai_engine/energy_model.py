import numpy as np

class EnergyModel:
    def predict(self, bio):
        hr = bio["heart_rate"]
        hrv = bio["hrv"]
        sleep = bio["sleep_debt"]
        stress = bio["stress"]
        motion = bio["movement"]

        fatigue = (
            (100 - hrv) * 0.35 +
            stress * 30 +
            sleep * 40 -
            motion * 10
        )

        energy = max(0, min(100, 100 - fatigue))
        focus = max(0, min(1, (hrv / 100) - stress))

        return {
            "energy": round(energy, 1),
            "fatigue": round(fatigue, 1),
            "focus": round(focus, 2)
        }
