import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';
import 'package:flutter/material.dart';



import 'status_badge.dart';

class CampaignCard extends StatelessWidget {
  final CampaignEntity campaign;

  const CampaignCard({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {

    final progress =
        campaign.spend / campaign.budget;

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// TOP ROW
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              Expanded(
                child: Text(
                  campaign.name,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              StatusBadge(
                status: campaign.status,
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// SPEND
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                'Spend',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                '\$${campaign.spend.toStringAsFixed(0)} / \$${campaign.budget.toStringAsFixed(0)}',
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// PROGRESS BAR
          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),

            child: LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              minHeight: 10,

              backgroundColor:
              Colors.grey.shade200,

              color: const Color(0xff5B67F1),
            ),
          ),

          const SizedBox(height: 20),

          /// METRICS
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              _metricItem(
                title: 'Impressions',
                value:
                campaign.impressions.toString(),
              ),

              _metricItem(
                title: 'Clicks',
                value:
                campaign.clicks.toString(),
              ),

              _metricItem(
                title: 'CTR',
                value:
                '${campaign.ctr.toStringAsFixed(2)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricItem({
    required String title,
    required String value,
  }) {
    return Column(
      children: [

        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}