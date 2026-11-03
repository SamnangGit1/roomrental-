import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:roomrental_app/feature/screens/homescreen.dart';
import 'package:roomrental_app/feature/screens/savedscreen.dart';
import 'package:roomrental_app/shared/colors/AppColor.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int currentIndex = 0;

  static const _duration = Duration(milliseconds: 220);
  static const _curve = Curves.easeOutCubic;

  final List<Widget> _pages = const [
    Homescreen(),
    SavedScreen(),
    Center(child: Text('Bookings Page')),
    Center(child: Text('Profile Page')),
  ];

  static const destinations = [
    (icon: Iconsax.discover, label: 'Explore'),
    (icon: Iconsax.heart, label: 'Saved'),
    (icon: Iconsax.calendar_tick, label: 'Bookings'),
    (icon: Iconsax.user, label: 'Profile'),
  ];

  Widget buildBottomNavigationBar() {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(10, 0, 10, 8),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(38),
          border: Border.all(color: const Color(0x220F1530)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x260F1530),
              blurRadius: 16,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / destinations.length;

            return Stack(
              children: [
                // Sliding gradient pill
                AnimatedPositioned(
                  duration: _duration,
                  curve: _curve,
                  left: currentIndex * itemWidth,
                  top: 0,
                  bottom: 0,
                  width: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.navGradientStart,
                            AppColors.navGradientEnd,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Tabs
                Row(
                  children: [
                    for (var i = 0; i < destinations.length; i++)
                      Expanded(child: _buildDestination(i)),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDestination(int index) {
    final item = destinations[index];
    final isSelected = currentIndex == index;
    final color = isSelected
        ? AppColors.navActiveColor
        : AppColors.navInactiveColorLight;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (index != currentIndex) setState(() => currentIndex = index);
        },
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: color),
          duration: _duration,
          curve: _curve,
          builder: (context, animatedColor, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 28, color: animatedColor),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    color: animatedColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: _pages[currentIndex],
    );
  }
}
