import 'package:flutterapp/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PlacesFetcher {
  
  static Future<String?> fetchPlaces(String query, {Map<String, String>? headers}) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, 
        "components": "country:ca" ,
        "key": APIkey,
        "region": "ca"
        
        });

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }
}
