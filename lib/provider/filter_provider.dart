import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<bool> {
  FilterNotifier(bool value) : super(value);

  bool poison = false;
  bool psychic = false;
  bool ground = false;
  bool fire = false;
}

final filterProvider = StateNotifierProvider<FilterNotifier, bool>((ref) {
  return FilterNotifier(false);
});
