import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';
import '../widgets/product_card.dart';
import '../widgets/product_empty.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);

  @override
  void initState() {
    // Fetch initial product data here, if necessary
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue.value = index;
    // Handle category selection
    String category = 'all';
    switch (index) {
      case 0:
        category = 'all';
        break;
      case 1:
        category = 'drink';
        break;
      case 2:
        category = 'food';
        break;
      case 3:
        category = 'snack';
        break;
    }

    // Fetch products by category if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Menu Cafe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.note_alt_rounded),
          ),
          const SpaceWidth(8)
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
            controller: searchController,
            onChanged: (value) {
              if (value.length > 3) {
                // Trigger search functionality
              }
              if (value.isEmpty) {
                // Reset product list
              }
            },
          ),
          const SpaceHeight(16.0),
          ValueListenableBuilder(
            valueListenable: indexValue,
            builder: (context, index, _) => Row(
              children: [
                MenuButton(
                  iconPath: Assets.icons.allCategories.path,
                  label: 'All',
                  isActive: index == 0,
                  onPressed: () => onCategoryTap(0),
                ),
                const SpaceWidth(10.0),
                MenuButton(
                  iconPath: Assets.icons.drink.path,
                  label: 'Drink',
                  isActive: index == 1,
                  onPressed: () => onCategoryTap(1),
                ),
                const SpaceWidth(10.0),
                MenuButton(
                  iconPath: Assets.icons.food.path,
                  label: 'Food',
                  isActive: index == 2,
                  onPressed: () => onCategoryTap(2),
                ),
                const SpaceWidth(10.0),
                MenuButton(
                  iconPath: Assets.icons.snack.path,
                  label: 'Snack',
                  isActive: index == 3,
                  onPressed: () => onCategoryTap(3),
                ),
              ],
            ),
          ),
          const SpaceHeight(16.0),
          // This section will display the list of products
          // For now, we'll simulate some products:
          // const ProductEmpty(), // Use this if no products are found

          // Example grid for displaying products, replace with actual data
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6, // Replace with dynamic product count
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemBuilder: (context, index) => ProductCard(),
          ),
        ],
      ),
    );
  }
}
