import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thousand_app/core/const/api_const.dart';
import 'package:thousand_app/core/models/news_models.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';
import 'package:thousand_app/core/utils/format_dates.dart';
import 'package:thousand_app/core/widgets/buttons.dart';
import 'package:thousand_app/core/widgets/image_network.dart';
import 'package:thousand_app/core/widgets/rating.dart';

class DetailNewsScreen extends StatelessWidget {
  final News news;
  const DetailNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 90,
        centerTitle: true,
        leading: Row(
          children: [
            CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                minSize: 0,
                padding: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textColor,
                )),
            Text(
              'news',
              style: AppTextStyles.textTheme.displayLarge,
            ),
          ],
        ),
        backgroundColor: AppColors.primaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            news.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.textTheme.displayMedium,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Stack(
                children: [
                  ImageNetworkWidget(
                    link: "$apiImage${news.posterPath}",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             NewsRating(rate:  news.voteAverage ?? 0.0),
                            FavoriteButton(
                              onPressed: () {},
                              isFavourite: false,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.textTheme.displayMedium!.copyWith(fontSize: 30),
                            ),
                            Text(
                             formatDateIntToString(news.releaseDate ?? ''),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Text(
                 news.overview ?? '',
                textAlign: TextAlign.start,
                style: AppTextStyles.textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
