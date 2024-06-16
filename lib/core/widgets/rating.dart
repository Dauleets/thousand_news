import 'package:flutter/material.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';

class NewsRating extends StatelessWidget {
  final double rate;
  const NewsRating({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 10,
            offset: Offset(0, 0),
            color: AppColors.darkBackgroundColor,
          ),
        ],
      ),
      child: Center(
        child: Text(
          rate.toStringAsFixed(2).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppTextStyles.textTheme.displaySmall!.copyWith(
            color: AppColors.darkBackgroundColor,
          ),
        ),
      ),
    );
  }
}


