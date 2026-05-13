import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),

        decoration: BoxDecoration(

          color: const Color(0xff1A1C29),

          borderRadius:
          BorderRadius.circular(16),
        ),

        child: TextField(

          style: const TextStyle(
            color: Colors.white,
          ),

          decoration: InputDecoration(

            border: InputBorder.none,

            hintText: 'Search Campaigns...',

            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),

            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),

            suffixIcon: const Icon(
              Icons.tune,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}