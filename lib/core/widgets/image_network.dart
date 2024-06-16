import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String link;
  const ImageNetworkWidget({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: link,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  AppColors.darkBackgroundColor.withOpacity(0.55),
                  BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.textColor,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor.withOpacity(0.5),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(
              Icons.error,
              color: AppColors.textColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Image not available',
              style: AppTextStyles.textTheme.bodyMedium!
                  .copyWith(color: AppColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}


