import 'dart:convert';
import 'package:http/http.dart ' as http;
import 'package:news_app49/model/news_model.dart';

class NewsApiService{

  static Future<List<Articles>> fetchNewsData({required int page,required sotBy}) async{
     List<Articles> newList =[];

    var link = Uri.parse('https://newsapi.org/v2/everything?q=bitcoin&apiKey=a7fe13d5fbb74b1380fdb2c94d97bae3&pageSize=10&page=$page&sortBY=$sotBy ');
  var response = await http.get(link);
  var data = jsonDecode(response.body);
  Articles articles;
  for(var i in data['articles'] ){
    articles = Articles.fromJson(i);
    newList.add(articles);
  }
  return newList;



   }



}