import 'package:flutter/material.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({super.key});

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  int _selectedIndex = 0;

  final List<String> _categories = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Drama',
    'Fantasy',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap:  true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                if (mounted) setState(() => _selectedIndex = index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInBack,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFFC107)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFFFC107)
                        : const Color(0xFFFFC107).withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : const Color(0xFFFFC107),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}