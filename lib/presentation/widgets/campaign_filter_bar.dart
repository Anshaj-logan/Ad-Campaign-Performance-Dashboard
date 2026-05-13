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

    return SizedBox(

      height: 50,

      child: ListView.builder(

        scrollDirection: Axis.horizontal,

        padding:
        const EdgeInsets.symmetric(
          horizontal: 16,
        ),

        itemCount: filters.length,

        itemBuilder: (context, index) {

          final filter = filters[index];

          final isSelected =
              selectedFilter == filter;

          return Padding(

            padding:
            const EdgeInsets.only(right: 10),

            child: ChoiceChip(

              label: Text(filter),

              selected: isSelected,

              onSelected: (_) =>
                  onSelected(filter),

              backgroundColor:
              const Color(0xff1A1C29),

              selectedColor:
              const Color(0xff35D6FF),

              labelStyle: TextStyle(

                color: isSelected
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}