import 'package:flutter/material.dart';

class CampaignFilterBar extends StatelessWidget {
  final String selectedFilter;

  final Function(String) onSelected;

  const CampaignFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {

    final filters = [
      'All',
      'Active',
      'Paused',
    ];

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      child: Row(
        children: filters.map((filter) {

          final isSelected =
              selectedFilter == filter;

          return Padding(
            padding:
            const EdgeInsets.only(right: 12),

            child: ChoiceChip(
              label: Text(filter),

              selected: isSelected,

              onSelected: (_) =>
                  onSelected(filter),

              selectedColor:
              const Color(0xff5B67F1),

              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}