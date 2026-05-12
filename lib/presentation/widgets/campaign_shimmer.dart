import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CampaignShimmer extends StatelessWidget {
  const CampaignShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount: 6,

      itemBuilder: (_, __) {

        return Padding(
          padding:
          const EdgeInsets.only(bottom: 16),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor:
            Colors.grey.shade100,

            child: Container(
              height: 180,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}