part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}
final class LoadedNews extends NewsState {
  final List<News> response;

  const LoadedNews({required this.response});
}
final class AddLoadedNews extends NewsState {
  final List<News> response;

  const AddLoadedNews({required this.response});
}
final class LoadingNews extends NewsState {}
final class ErrorNews extends NewsState {
  final String? message;

  const ErrorNews({required this.message});
}