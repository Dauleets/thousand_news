import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:thousand_app/core/theme/colors.dart';

class FetchMoreIndicator extends StatelessWidget {
  final Widget child;
  final VoidCallback onAction;

  const FetchMoreIndicator({
    super.key,
    required this.child,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    const height = 150.0;
    return CustomRefreshIndicator(
      onRefresh: () async => onAction(),
      trigger: IndicatorTrigger.trailingEdge,
      trailingScrollIndicatorVisible: false,
      leadingScrollIndicatorVisible: true,
      child: child,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final dy = controller.value.clamp(0.0, 1.25) *
                  -(height - (height * 0.25));
              return Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0.0, dy),
                    child: child,
                  ),
                  Positioned(
                    bottom: -height,
                    left: 0,
                    right: 0,
                    height: height,
                    child: Container(
                      transform: Matrix4.translationValues(0.0, dy, 0.0),
                      padding: const EdgeInsets.only(top: 50.0),
                      constraints: const BoxConstraints.expand(),
                      child: Column(
                        children: [
                          if (controller.isLoading)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              width: 26,
                              height: 26,
                              child: const CircularProgressIndicator(
                                color: AppColors.darkBackgroundColor,
                                strokeWidth: 4,
                              ),
                            )
                          else
                            const Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.textColor,
                            ),
                          Text(
                            controller.isLoading
                                ? "Fetching..."
                                : "Pull to fetch more",
                            style: const TextStyle(
                              color: AppColors.textColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
