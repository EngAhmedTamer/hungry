import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_colors.dart';
import 'features/auth/view/profile_view.dart';
import 'features/cart/views/cart_view.dart';
import 'features/home/views/home_view.dart';
import 'features/order_history/views/order_history_view.dart';

class Root extends StatefulWidget {
  Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with SingleTickerProviderStateMixin {
  late final PageController controller;
  late final List<Widget> screens;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      HomeView(),
      CartView(),
      OrderHistoryView(),
      ProfileView(),
    ];
    controller = PageController(initialPage: currentIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
        controller.jumpToPage(index);
      });
      _animationController.forward(from: 0.0).then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isDark ? colorScheme.background : colorScheme.background,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: screens,
        ),
        bottomNavigationBar: _ModernGlassmorphicNavBar(
          currentIndex: currentIndex,
          onTap: _onItemTapped,
          isDark: isDark,
          colorScheme: colorScheme,
        ),
      ),
    );
  }
}

class _ModernGlassmorphicNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isDark;
  final ColorScheme colorScheme;


  const _ModernGlassmorphicNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return keyboardOpen
        ? const SizedBox.shrink()
        : Transform.translate(
          offset: const Offset(0, -20),
          child: ClipRRect(

            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            colorScheme.primary.withOpacity(0.25),
                            colorScheme.secondary.withOpacity(0.15),
                          ]
                        : [
                            Colors.white.withOpacity(0.9),
                            Colors.white.withOpacity(0.85),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.5)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.white.withOpacity(0.8),
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      icon: CupertinoIcons.home,
                      label: 'Home',
                      index: 0,
                      currentIndex: currentIndex,
                      onTap: onTap,
                      isDark: isDark,
                      colorScheme: colorScheme,
                    ),
                    _NavBarItem(
                      icon: CupertinoIcons.shopping_cart,
                      label: 'Cart',
                      index: 1,
                      currentIndex: currentIndex,
                      onTap: onTap,
                      isDark: isDark,
                      colorScheme: colorScheme,
                    ),
                    _NavBarItem(
                      icon: CupertinoIcons.arrow_2_circlepath,
                      label: 'History',
                      index: 2,
                      currentIndex: currentIndex,
                      onTap: onTap,
                      isDark: isDark,
                      colorScheme: colorScheme,
                    ),
                    _NavBarItem(
                      icon: CupertinoIcons.person,
                      label: 'Profile',
                      index: 3,
                      currentIndex: currentIndex,
                      onTap: onTap,
                      isDark: isDark,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;
  final bool isDark;
  final ColorScheme colorScheme;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    if (widget.index == widget.currentIndex) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index == widget.currentIndex && oldWidget.index != widget.currentIndex) {
      _controller.forward();
    } else if (widget.index != widget.currentIndex && oldWidget.index == widget.currentIndex) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isSelected => widget.index == widget.currentIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: widget.isDark
                                  ? [
                                      widget.colorScheme.primary,
                                      widget.colorScheme.secondary,
                                    ]
                                  : [
                                      widget.colorScheme.primary,
                                      widget.colorScheme.secondary,
                                    ],
                            )
                          : null,
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: widget.colorScheme.primary.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: widget.colorScheme.primary.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      widget.icon,
                      color: isSelected
                          ? Colors.white
                          : (widget.isDark
                              ? Colors.white.withOpacity(0.6)
                              : widget.colorScheme.primary.withOpacity(0.6)),
                      size: 22,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.inter(
                fontSize: isSelected ? 11 : 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? widget.colorScheme.primary
                    : (widget.isDark
                        ? Colors.white.withOpacity(0.6)
                        : widget.colorScheme.primary.withOpacity(0.6)),
                letterSpacing: 0.2,
              ),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}
