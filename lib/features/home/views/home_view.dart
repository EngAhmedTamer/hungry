 import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 160,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 38, right: 20, left: 20),
                child: Column(
                  children: [
                    UserHeaders(name: 'Ahmed ', image: 'assets/test/test.png'),
                    SearchField(),
                  ],
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
                    Gap(25),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FoodCategory(
                        currentIndex: currentIndex,
                        category: category,
                      ),
                    ),
                    Gap(25),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) {
                            return ProductDetailsView();
                          },
                        ),
                      );
                    },
                    child: CardItem(
                      image: 'assets/test/test.png',
                      text: 'Cheeseburger',
                      desc: 'Wendy"s burger',
                      rate: '4.5',
                    ),

                  );

                }, childCount: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.67,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 100,)
            )
          ],
        ),
      ),
    );
  }
}
