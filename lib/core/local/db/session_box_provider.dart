import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:parking_app/core/local/db/hive_box_key.dart';

final sessionBoxProvider = Provider<Box>((ref) {
  return Hive.box(sessionBox);
});
