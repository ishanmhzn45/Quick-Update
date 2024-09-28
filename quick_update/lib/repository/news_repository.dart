import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quick_update/models/categories_models.dart';
import 'package:http/http.dart' as http;

class NewsRepository {

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async {
    String url = 'https://newsapi.org/v2/everything?q=$category&apiKey=9a416e88aeac4fd6b16bfcb4a7163d15';
    if (kDebugMode) {
      print(url);
    }
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if (response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}