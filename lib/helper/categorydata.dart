import 'package:practice/model/categorymodel.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];

  categories.add(CategoryModel(
    categoryName: 'Gaming',
    imageUrl:
        'https://i.ytimg.com/vi/EA0YC9m6D4s/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCPEDlv0VGPIr2CC_juaUkgVRDJDQ',
  ));

  categories.add(CategoryModel(
    categoryName: 'India',
    imageUrl:
        'https://images.pexels.com/photos/3476860/pexels-photo-3476860.jpeg',
  ));

  categories.add(CategoryModel(
    categoryName: 'Entertainment',
    imageUrl:
        'https://miro.medium.com/v2/resize:fit:1400/1*L-asxOmJoI1G2SrCkxlsgA.jpeg',
  ));

  categories.add(CategoryModel(
    categoryName: 'Business',
    imageUrl:
        'https://online.hbs.edu/Style%20Library/api/resize.aspx?imgpath=/PublishingImages/overhead-view-of-business-strategy-meeting.jpg&w=1200&h=630',
  ));

  categories.add(CategoryModel(
    categoryName: 'Sports',
    imageUrl:
        'https://th-i.thgim.com/public/sport/football/clqjh8/article68330440.ece/alternates/LANDSCAPE_385/Belgium.jpg',
  ));

  categories.add(CategoryModel(
    categoryName: 'Health',
    imageUrl:
        'https://www.waldenu.edu/media/5021/seo-1568-bs-222353704-1200x675',
  ));

  categories.add(CategoryModel(
    categoryName: 'Science',
    imageUrl:
        'https://epi-rsc.rsc-cdn.org/globalassets/05-journals-books-databases/our-journals/00-journal-pages-heros/Chemical-Science-HERO.jpg?version=9e72b3c3',
  ));

  return categories;
}
