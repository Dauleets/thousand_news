import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';
import 'package:thousand_app/news/bloc/news_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final Function() onPressed;
  final bool isFavourite;
  const FavoriteButton(
      {super.key, required this.onPressed, required this.isFavourite});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onPressed,
      child: Container(
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
          child: Icon(
            isFavourite ? Icons.star : Icons.star_border,
            size: 30,
            color: isFavourite ? Colors.amber : Colors.black38,
          ),
        ),
      ),
    );
  }
}

class ReloadButtonWidget extends StatelessWidget {
  const ReloadButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Container(
          width: 200,
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.textColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reload',
                  style: AppTextStyles.textTheme.displayMedium!
                      .copyWith(color: AppColors.backgroundColor),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.update)
              ],
            ),
          ),
        ),
        onPressed: () {
          BlocProvider.of<NewsBloc>(context).add(const GetNewsEvent());
        });
  }
}
