import 'package:hive/hive.dart';
import 'package:mcn_app/constants/constants.dart';

class HiveHelper {
  static String? getString(String key) {
    var box = Hive.box(HiveConstant.box);
    return box.get(key);
  }

 static Future<void> putString(String key, String value) async {
    var box = Hive.box(HiveConstant.box);
    await box.put(key, value);
  }
}
