import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thousand_app/core/generated/assets.gen.dart';
import 'package:thousand_app/core/models/news_models.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';
import 'package:thousand_app/core/utils/refresh_indicators.dart';
import 'package:thousand_app/news/bloc/news_bloc.dart';
import 'package:thousand_app/news/view/home/home_widgets.dart';
import 'package:thousand_app/news/view/home/states_screens.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List<News> list = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(const GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is LoadedNews) {
          setState(() {
            list.addAll(state.response);
          });
        } else if (state is AddLoadedNews) {
          setState(() {
            list.addAll(state.response);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 10,
            backgroundColor: AppColors.darkBackgroundColor.withOpacity(0.2),
            title: Text(
              'News',
              style: AppTextStyles.textTheme.displayMedium,
            ),
            
            leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Assets.images.launcher.image(fit: BoxFit.fill)),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Builder(
              builder: (context) {
                if (state is LoadingNews && list.isEmpty) {
                  return const LoadingBodyWidget();
                } else if (state is LoadedNews || list.isNotEmpty) {
                  return HomeBodyWidget(news: list);
                } else if (state is ErrorNews) {
                  return ErrorBodyWidget(errorMessage: state.message);
                } else {
                  return const NotStateBodyWidget();
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class HomeBodyWidget extends StatefulWidget {
  final List<News> news;

  const HomeBodyWidget({super.key, required this.news});

  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  List<News> news = [];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    news = List.from(widget.news);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMore();
      }
    });
  }

  Future<void> _fetchMore() async {
    Future.delayed(const Duration(seconds: 1));
    BlocProvider.of<NewsBloc>(context).add(const GetAddNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is AddLoadedNews) {
          setState(() {
            var newItems = state.response
                .where((newItem) => !news.contains(newItem))
                .toList();

            news.addAll(newItems);
          });
        }
      },
      builder: (context, state) {
        if (state is LoadingNews && news.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorNews) {
          return Center(child: Text(state.message ?? 'An error occurred'));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FetchMoreIndicator(
            key: _refreshIndicatorKey,
            onAction: _fetchMore,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: news.length,
              itemBuilder: (context, index) {
                return NewsCard(newsItem: news[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
