import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rms_company/core/utils/custom_converter.dart';

class DetectUriApi {
  static String get uriApi => '${_uriApi!}api';

  static set uriApi(String uri) => _uriApi = uri;
  static String? _uriApi;
}
