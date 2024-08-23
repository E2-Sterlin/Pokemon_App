import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProvider extends StateNotifier<Map<String, dynamic>> {
  SearchProvider(super._state, {required this.number});
  final String number;
}
