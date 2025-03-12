import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for accessing BuildContext throughout the app
/// Will be initialized in the MyApp build method
final contextProvider = StateProvider<BuildContext>((ref) {
  throw UnimplementedError('Context provider not initialized');
});