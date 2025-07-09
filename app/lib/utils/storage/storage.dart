import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  StorageService._privateConstructor();
  static final StorageService _instance = StorageService._privateConstructor();
  static StorageService get instance => _instance;



  StorageService._internal();

  void write(String key, dynamic value) {
    _box.write(key, value);
  }

  dynamic read(String key) {
    return _box.read(key);
  }

  void remove(String key) {
    _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }
}