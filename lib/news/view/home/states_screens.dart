import 'package:flutter/material.dart';
import 'package:thousand_app/core/theme/colors.dart';
import 'package:thousand_app/core/theme/text_theme.dart';
import 'package:thousand_app/core/widgets/buttons.dart';


class NotStateBodyWidget extends StatelessWidget {
  const NotStateBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkBackgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('The news did not load. Please try again later.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textTheme.displaySmall),
              const SizedBox(height: 40),
              const ReloadButtonWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorBodyWidget extends StatelessWidget {
  final String? errorMessage;
  const ErrorBodyWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkBackgroundColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(errorMessage ?? "loading error",
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.textTheme.displaySmall),
            const SizedBox(height: 40),
            const ReloadButtonWidget()
          ],
        ),
      ),
    );
  }
}


class LoadingBodyWidget extends StatelessWidget {
  const LoadingBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColors.darkBackgroundColor,
              strokeWidth: 15.0,
            ),
            const SizedBox(height: 50),
            Text('Please wait, news is loading...',
                textAlign: TextAlign.center,
                style: AppTextStyles.textTheme.displaySmall),
          ],
        ),
      ),
    );
  }
}
