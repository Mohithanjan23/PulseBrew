class CaffeineModel:
    def update(self, before, after):
        return (after["energy"] - before["energy"]) / 50
