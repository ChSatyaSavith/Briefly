import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:practice/helper/gemini.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  final String title, url, urlToImage;

  const ArticlePage({
    super.key,
    required this.title,
    required this.url,
    required this.urlToImage,
  });

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  String generatedText = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPrompt();
  }

  getPrompt() async {
    Gemini gemini = Gemini(url: widget.url);
    await gemini.getGen();
    setState(() {
      generatedText = gemini.generated_text;
      isLoading = false;
    });
  }

  void _launchURL() async {
    if (await canLaunch(widget.url)) {
      await launch(widget.url);
    } else {
      throw 'Could not launch ${widget.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: widget.urlToImage,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (generatedText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        generatedText,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: _launchURL,
                      child: Text(
                        widget.url,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
