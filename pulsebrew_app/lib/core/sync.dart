import 'package:http/http.dart' as http;

class Sync {
  static Future send(Map data) async {
    await http.post(
      Uri.parse("https://pulsebrew.supabase.co/sync"),
      body: data
    );
  }
}
