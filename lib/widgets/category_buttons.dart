import 'package:flutter/material.dart';

class CategoryButtons extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryButtons({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _CategoryButton(
            label: 'Все',
            isSelected: selectedCategory == 'Все',
            onTap: () => onCategorySelected('Все'),
          ),
          const SizedBox(width: 8),
          _CategoryButton(
            label: 'Wi-Fi',
            isSelected: selectedCategory == 'Wi-Fi',
            onTap: () => onCategorySelected('Wi-Fi'),
          ),
          const SizedBox(width: 8),
          _CategoryButton(
            label: 'Еда',
            isSelected: selectedCategory == 'Еда',
            onTap: () => onCategorySelected('Еда'),
          ),
          const SizedBox(width: 8),
          _CategoryButton(
            label: 'Повербанки',
            isSelected: selectedCategory == 'Повербанки',
            onTap: () => onCategorySelected('Повербанки'),
            icon: Icons.bolt,
          ),
        ],
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const _CategoryButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1a237e) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.amber,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

