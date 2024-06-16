import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_app/core/models/news_models.dart';
import 'package:thousand_app/news/view/details/details_screen.dart';
import 'package:thousand_app/news/view/home/home_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const NewsHomePage(),
        routes: [
          GoRoute(
            path: 'details',
            builder: (context, state) {
              final news = state.extra as News?;
              if (news == null) {
                return Scaffold(
                  appBar: AppBar(title: const Text('Ошибка')),
                  body: const Center(
                      child: Text('Не удалось загрузить данные новости')),
                );
              }
              return DetailNewsScreen(news: news);
            },
          ),
        ]),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Ошибка')),
    body: const Center(child: Text('Ошибка при навигации')),
  ),
);
