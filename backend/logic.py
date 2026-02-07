import math
from datetime import datetime, timedelta

class CaffeineDecayModel:
    """
    A deterministic model to estimate caffeine plasma levels and recommend intake.
    Based on a standard half-life of 5 hours (adjustable).
    """
    HALF_LIFE_HOURS = 5.0
    
    @staticmethod
    def calculate_plasma_level(amount_mg: float, time_elapsed_hours: float) -> float:
        """
        Calculate remaining caffeine using exponential decay: N(t) = N0 * (1/2)^(t/t_1/2)
        """
        if time_elapsed_hours < 0:
            return 0.0
        return amount_mg * pow(0.5, time_elapsed_hours / CaffeineDecayModel.HALF_LIFE_HOURS)

    @staticmethod
    def get_recommendation(current_level: float, heart_rate: int = 70) -> dict:
        """
        Generate a recommendation based on current plasma level and biometrics.
        Thresholds:
        - Max efficient plasma level: ~200mg equivalent (jitters start above this for many)
        - Min efficient plasma level: ~50mg (below this, effects estimate to be negligible)
        """
        
        # Biometric Guardrails
        if heart_rate > 100:
             return {
                "should_consume": False,
                "reason": "Heart rate is elevated. Caffeine not recommended.",
                "recommended_amount_mg": 0.0
            }

        # Plasma Level Logic
        if current_level > 150.0:
            return {
                "should_consume": False,
                "reason": "Caffeine levels are high. Consuming more may cause jitters.",
                "recommended_amount_mg": 0.0
            }
        elif current_level < 50.0:
             return {
                "should_consume": True,
                "reason": "Levels are low. A small boost could help focus.",
                "recommended_amount_mg": 80.0 # Standard cup of coffee
            }
        else:
             return {
                "should_consume": True,
                "reason": "Levels are moderate. You can top up if needed.",
                "recommended_amount_mg": 40.0 # Half cup / tea
            }

    @staticmethod
    def process_request(last_intake_time: datetime, last_intake_amount: float, current_time: datetime, heart_rate: int = 70) -> dict:
        """
        Facade to process a full request.
        """
        if not last_intake_time:
            return CaffeineDecayModel.get_recommendation(0.0, heart_rate)

        delta = current_time - last_intake_time
        hours_elapsed = delta.total_seconds() / 3600.0
        
        current_level = CaffeineDecayModel.calculate_plasma_level(last_intake_amount, hours_elapsed)
        
        rec = CaffeineDecayModel.get_recommendation(current_level, heart_rate)
        rec["current_plasma_level"] = round(current_level, 2)
        
        # Calculate when it will be safe/effective to drink again (drops below 50mg)
        # N(t) = 50 => 50 = N0 * 0.5^(t/5)
        # t/5 * ln(0.5) = ln(50/N0)
        # t = 5 * ln(50/N0) / ln(0.5)
        
        if current_level > 50:
             # Calculate hours until it drops to 50
             time_to_drop = 5 * math.log(50 / current_level) / math.log(0.5)
             rec["next_allowable_intake"] = current_time + timedelta(hours=time_to_drop)
        else:
             rec["next_allowable_intake"] = current_time

        return rec
