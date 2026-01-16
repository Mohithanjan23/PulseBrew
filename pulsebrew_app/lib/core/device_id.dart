import 'package:uuid/uuid.dart';

class DeviceID {
  static final Uuid _uuid = const Uuid();

  static String generate() {
    return _uuid.v4();
  }
}
