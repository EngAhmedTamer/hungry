import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/glassmorphic_container.dart';
import '../../../shared/custom_text.dart';

class UserHeaders extends StatelessWidget {
  const UserHeaders({super.key, required this.name, this.image});
  final String name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(30),
            Center(
              child: SvgPicture.asset(
                'assets/logo/logo.svg',
                color: colorScheme.primary,
                height: 35,
              ),
            ),
            const Gap(8),
            CustomText(
              text: 'Hello $name',
              color: isDark ? Colors.white70 : Colors.grey.shade600,
              weight: FontWeight.w500,
              size: 18,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GlassmorphicContainer(
            borderRadius: BorderRadius.circular(35),
            padding: const EdgeInsets.all(3),
            child: CircleAvatar(
              radius: 31,
              backgroundColor: Colors.transparent,
              child: image != null
                  ? ClipOval(
                      child: Image(
                        image: AssetImage(image!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 40,
                      color: colorScheme.primary,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
