import 'dart:async';
import 'package:http/http.dart' as http;

class CanadaServiceApi {
  static Future getItems() {
    return http.get(Uri.parse("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"));
  }
}
