import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


class StorageService {

  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late GetStorage _box;
  bool _isInitialized = false;



  final String userDataKey = "user_data";
  final String authTokenKey = "auth_token";

  // Initialize GetStorage
  Future<void> initialize() async {
    if (_isInitialized) return;

    _box = GetStorage();
    _isInitialized = true;
    debugPrint('✅ StorageService initialized');
  }

  // Check if initialized
  void _checkInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'StorageService not initialized. Call initialize() first.',
      );
    }
  }

  // Save string
  Future<void> setString(String key, String value) async {
    _checkInitialized();
    await _box.write(key, value);
    debugPrint('💾 Saved: $key = $value');
  }

  // Get string
  String? getString(String key) {
    _checkInitialized();
    final value = _box.read<String>(key);
    debugPrint('📖 Read: $key = $value');
    return value;
  }

  // Save int
  Future<void> setInt(String key, int value) async {
    _checkInitialized();
    await _box.write(key, value);
  }

  // Get int
  int? getInt(String key) {
    _checkInitialized();
    return _box.read<int>(key);
  }

  // Save bool
  Future<void> setBool(String key, bool value) async {
    _checkInitialized();
    await _box.write(key, value);
  }

  // Get bool
  bool? getBool(String key) {
    _checkInitialized();
    return _box.read<bool>(key);
  }

  // Save double
  Future<void> setDouble(String key, double value) async {
    _checkInitialized();
    await _box.write(key, value);
  }

  // Get double
  double? getDouble(String key) {
    _checkInitialized();
    return _box.read<double>(key);
  }

  // Save object (Map/List)
  Future<void> setObject(String key, dynamic value) async {
    _checkInitialized();
    await _box.write(key, value);
  }

  // Get object
  dynamic getObject(String key) {
    _checkInitialized();
    return _box.read(key);
  }

  // Remove key
  Future<void> remove(String key) async {
    _checkInitialized();
    await _box.remove(key);
    debugPrint('🗑️ Removed: $key');
  }

  // Check if key exists
  bool containsKey(String key) {
    _checkInitialized();
    return _box.hasData(key);
  }

  // Clear all data
  Future<void> clearAll() async {
    _checkInitialized();
    await _box.erase();
    debugPrint('🗑️ All data cleared');
  }






}
