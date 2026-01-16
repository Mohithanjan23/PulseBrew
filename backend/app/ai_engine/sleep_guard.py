def caffeine_allowed(hour, sleep_debt):
    if hour >= 17:
        return False
    if sleep_debt > 0.5:
        return False
    return True
