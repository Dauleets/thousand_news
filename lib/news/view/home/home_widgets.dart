import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:thousand_app/core/const/api_const.dart';
import 'package:thousand_app/core/models/news_models.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';
import 'package:thousand_app/core/utils/format_dates.dart';
import 'package:thousand_app/core/widgets/buttons.dart';
import 'package:thousand_app/core/widgets/image_network.dart';
import 'package:thousand_app/core/widgets/rating.dart';

class NewsCard extends StatelessWidget {
  final News newsItem;
  const NewsCard({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.darkBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CupertinoButton(
        onPressed: () {
          context.go('/details', extra: newsItem);
        },
        padding: EdgeInsets.zero,
        minSize: 0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageNetworkWidget(
                link: "$apiImage${newsItem.posterPath}",
              ),
            ),
            Container(
              height: 350,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NewsRating(rate: newsItem.voteAverage ?? 0.0),
                      FavoriteButton(
                        onPressed: () {},
                        isFavourite: false,
                      ),
                    ],
                  ),
                  const Spacer(),
                  NewsFooter(
                    title: newsItem.title ?? '',
                    date: formatDateIntToString(newsItem.releaseDate ?? ''),
                  ),
                  const Spacer()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsFooter extends StatelessWidget {
  final String title;
  final String date;

  const NewsFooter({super.key, required this.title, required this.date});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: AppTextStyles.textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            date,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: AppTextStyles.textTheme.displaySmall!,
          ),
        ],
      ),
    );
  }
}

