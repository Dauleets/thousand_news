import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:thousand_app/core/models/news_models.dart';
import 'package:thousand_app/news/data/datasource.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsDataSource _dataSource = GetIt.instance<NewsDataSource>();

  NewsBloc() : super(NewsInitial()) {
    on<GetNewsEvent>((event, emit) async {
      emit(LoadingNews());
      final result = await _dataSource.fetchNews(false);
      result.fold(
        (error) => emit(ErrorNews(message: error)),
        (news) => emit(LoadedNews(response: news)),
      );
    });

    on<GetAddNewsEvent>((event, emit) async {
      final result = await _dataSource.fetchNews(true);
      result.fold(
        (error) => emit(ErrorNews(message: error)),
        (news) => emit(AddLoadedNews(response: news)),
      );
      emit(NewsInitial());
    });
  }
}
