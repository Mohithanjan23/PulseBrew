class LocalStorage {
  final Map<String, dynamic> _cache = {};

  void save(String key, dynamic value) {
    _cache[key] = value;
  }

  dynamic read(String key) {
    return _cache[key];
  }
}
