import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class _RootState extends State<Root> {
  late final PageController controller;
  late final List<Widget> screens;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            children: screens,
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                  currentIndex: currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.shopping_cart), label: 'Cart'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.arrow_2_circlepath),
                        label: 'History'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person), label: 'Profile'),
                  ],
                  onTap: (v) {
                    setState(() {
                      currentIndex = v;
                      controller.jumpToPage(v);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
