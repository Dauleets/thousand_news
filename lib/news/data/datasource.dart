import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thousand_app/core/config/remote_config.dart';
import 'package:thousand_app/core/models/news_models.dart';

class NewsDataSource {
  int _currentPage = 1;
  String _token = '';
  final Dio _dio = Dio();
  final _remoteConfig = GetIt.instance<RemoteConfigService>();

  Future<NewsDataSource> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    final token = _remoteConfig.getString(ConfigKey.token);
    await _saveTokenFromHive(token);
    return this;
  }

  Future<Either<String, List<News>>> fetchNews(bool addNewPage) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == [ConnectivityResult.none]) {
        List<News> cachedNews = await loadCachedNews();
        if (cachedNews.isEmpty) {
          return const Left('There is no internet connection. No cached data.');
        }
        return Right(cachedNews);
      }

      await _loadTokenFromHive();

      if (addNewPage) {
        _currentPage++;
        await _savePageToHive(_currentPage);
      } else {
        _currentPage = 1;
        await _savePageToHive(_currentPage);
      }

      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/now_playing',
        queryParameters: {
          'language': 'en-US',
          'page': _currentPage,
        },
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $_token',
          },
        ),
      );

      if (response.statusCode == 401) {
        return const Left('Token is invalid');
      } else if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        final List<News> newsList =
            results.map((json) => News.fromJson(json)).toList();

        if (!addNewPage) {
          await _saveNewsToCache(newsList);
        }

        return Right(newsList);
      } else {
        return Left('Error while receiving data: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException && e.error is SocketException) {
        return const Left(
            'Отсутствует подключение к интернету. Проверьте ваше подключение и повторите попытку.');
      }
      return Left('Error executing request: ${e.toString()}');
    }
  }

  Future<List<News>> loadCachedNews() async {
    final box = await Hive.openBox<News>('newsBox');
    return box.isEmpty ? [] : box.values.toList(); 
  }

  Future<void> _saveNewsToCache(List<News> newsList) async {
    final box = await Hive.openBox<News>('newsBox');
    await box.clear(); 
    for (var news in newsList) {
      await box.add(news); 
    }
  }

  Future<void> _savePageToHive(int page) async {
    final box = await Hive.openBox<int>('currentPage');
    await box.put('currentPage', page);
  }

  Future<void> _loadTokenFromHive() async {
    final box = await Hive.openBox<String>('token');
    _token = box.get('token')!;
  }

  Future<void> _saveTokenFromHive(String token) async {
    final box = await Hive.openBox<String>('token');
    await box.put('token', token);
  }
}