import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:thousand_app/core/config/remote_config.dart';
import 'package:thousand_app/core/models/news_models.dart';
import 'package:thousand_app/news/bloc/news_bloc.dart';
import 'package:thousand_app/news/data/datasource.dart';

class ServiceLocator {
  static Future<void> setup() async {
    GetIt.I.registerSingletonAsync<RemoteConfigService>(
        () => RemoteConfigService().init());
    await GetIt.I.isReady<RemoteConfigService>();
    
    GetIt.I
        .registerSingletonAsync<NewsDataSource>(() => NewsDataSource().init());
    await GetIt.I.isReady<NewsDataSource>();

    GetIt.I.registerLazySingleton<NewsBloc>(() => NewsBloc());

    Hive.registerAdapter(NewsAdapter());
  }
}
