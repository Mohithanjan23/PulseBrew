import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'local_database.dart';

class SyncRepository {
  final SupabaseClient _supabase;
  final LocalDatabase _localDb;

  SyncRepository(this._supabase, this._localDb);

  Future<void> syncData() async {
    // Check connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      debugPrint("No internet connection. Skipping sync.");
      return;
    }

    try {
      await _pushLocalChanges();
      // await _pullRemoteChanges(); // Implement if needed for multi-device sync
    } catch (e) {
      debugPrint("Sync failed: $e");
    }
  }

  Future<void> _pushLocalChanges() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    // 1. Sync Intakes
    final unsyncedIntakes = await _localDb.getUnsyncedIntakes();
    for (var intake in unsyncedIntakes) {
      try {
        await _supabase.from('intake_logs').upsert({
          'id': intake['id'],
          'user_id': userId,
          'beverage_name': intake['beverage_name'],
          'caffeine_amount_mg': intake['caffeine_amount_mg'],
          'timestamp': intake['timestamp'],
        });
        await _localDb.markIntakeSynced(intake['id']);
      } catch (e) {
        debugPrint("Failed to sync intake ${intake['id']}: $e");
      }
    }

    // 2. Sync Biometrics
    final unsyncedBiometrics = await _localDb.getUnsyncedBiometrics();
    for (var biometric in unsyncedBiometrics) {
      try {
        await _supabase.from('biometrics').upsert({
          'id': biometric['id'],
          'user_id': userId,
          'heart_rate_bpm': biometric['heart_rate_bpm'],
          'activity_level': biometric['activity_level'],
          'timestamp': biometric['timestamp'],
        });
        await _localDb.markBiometricSynced(biometric['id']);
      } catch (e) {
        debugPrint("Failed to sync biometric ${biometric['id']}: $e");
      }
    }
  }
}
