import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class getHTML {
  String url;
  String text = '';
  getHTML({required this.url});

  Future<void> fetchHTML() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final String extractedText = document.body?.text ?? '';
        text = extractedText;
      } else {
        text = 'no';
        throw Exception('Failed to load HTML');
      }
    } catch (e) {
      print(e);
    }
  }
}
