import 'package:get/get.dart';
import 'package:mono_app/lang/en_US.dart';
import 'package:mono_app/lang/id_ID.dart';

class Lang extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': en_us_tr,
    'id_ID': id_id_tr
  };
}