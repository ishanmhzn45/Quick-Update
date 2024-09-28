import 'package:quick_update/models/categories_models.dart';
import 'package:quick_update/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}