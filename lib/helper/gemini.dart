import 'package:practice/helper/getterhtml.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Gemini {
  String url;
  String generated_text = '';

  Gemini({required this.url});

  Future<void> getGen() async {
    getHTML gethtml = getHTML(url: url);
    await gethtml.fetchHTML();
    String text = gethtml.text;
    final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: 'AIzaSyBHph_xm4eCotZmH6vK9Oc3uG58pUEysr4');
    final content = [
      Content.text(
          'generate a catchy summary for this news article with content (dont include titles or special character only proffesional summary and output should only be text and make sure the summary includes the important stuff in the article and is a tad bit long): $text')
    ];
    final response = await model.generateContent(content);
    if (gethtml.text == 'no') {
      generated_text = 'no';
    } else {
      generated_text = response.text!;
    }
  }
}
