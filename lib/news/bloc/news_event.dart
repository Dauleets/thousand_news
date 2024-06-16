part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

final class GetNewsEvent extends NewsEvent {
  const GetNewsEvent();
}

final class GetAddNewsEvent extends NewsEvent {
  const GetAddNewsEvent();
}
