import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practice/helper/categorydata.dart';
import 'package:practice/helper/newsData.dart';
import 'package:practice/model/categorymodel.dart';
import 'package:practice/model/newsmodel.dart';
import 'package:practice/views/article_page.dart';
import 'package:practice/views/querypage.dart';

class Categorypage extends StatefulWidget {
  final String category;
  const Categorypage({super.key, required this.category});

  @override
  State<Categorypage> createState() => _CategorypageState();
}

class _CategorypageState extends State<Categorypage> {
  List<ArticleModel> articles = [];
  List<CategoryModel> categories = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  bool _loading = true;
  getNews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.data;
    categories = getCategories();
    log('Articles fetched: ${articles.length}');
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 20.0, // Height of the small white app bar
                      color: Colors.black,
                      child: const Center(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Search Category",
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: Colors.white12,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  isSearchActive = value.trim().isNotEmpty;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: isSearchActive
                                ? () {
                                    String category = searchController.text
                                        .trim()
                                        .toLowerCase();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QPage(category: category),
                                      ),
                                    );
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    ListView.builder(
                      itemCount: articles.length,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Template(
                              title: articles[index].title,
                              description: articles[index].description,
                              url: articles[index].url,
                              urlToImage: articles[index].urlToImage,
                            ),
                            const Divider(
                              color: Colors.grey, // Set the color to grey
                              thickness: 0.5, // Set the thickness
                              height: 0.5, // Set the height
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class Template extends StatelessWidget {
  final String title, description, url, urlToImage;
  const Template(
      {super.key,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(
              title: title,
              url: url,
              urlToImage: urlToImage,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0), // Added margin for better spacing
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: urlToImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator()), // Placeholder
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error), // Error widget
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  style: const TextStyle(color: Colors.white60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl;
  const CategoryTile(
      {super.key, required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Categorypage(category: categoryName.toLowerCase())));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 170,
                  height: 100,
                  fit: BoxFit.cover),
            ),
            Container(
              width: 170,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              alignment: Alignment.center,
              child: Text(categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
