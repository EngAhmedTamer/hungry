import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/features/home/widgets/card_item.dart';
import 'package:hungry/features/home/widgets/user_headers.dart';
import '../../product/views/product_details_view.dart';
import '../widgets/food_category.dart';
import '../widgets/search_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = [' All ', ' Combo ', ' Sliders ', 'Classic '];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: isDark ? colorScheme.background : colorScheme.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 160,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [
                            colorScheme.surface.withOpacity(0.3),
                            colorScheme.background,
                          ]
                        : [
                            Colors.white.withOpacity(0.9),
                            colorScheme.background,
                          ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 21, right: 20, left: 20,bottom: 1),
                  child: Column(
                    children: [
                      UserHeaders(
                        name: 'Ahmed ',
                        image: 'assets/test/test.png',
                      ),
                      const Gap(12),
                      const SearchField(),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    const Gap(25),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FoodCategory(
                        currentIndex: currentIndex,
                        category: category,
                      ),
                    ),
                    const Gap(25),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CardItem(
                      image: 'assets/test/test.png',
                      text: 'Cheeseburger',
                      desc: 'Wendy"s burger',
                      rate: '4.5',
                    );
                  },
                  childCount: 6,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.73,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}
