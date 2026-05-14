import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'status_badge.dart';

class CampaignCard extends StatelessWidget {
  final CampaignEntity campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final progress = campaign.spend / campaign.budget;

    return GestureDetector(

      onTap: () {

        context.pushNamed(
          'campaign-detail',
          extra: campaign,
        );
      },

      child:  Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xff1A1C29),

          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: Colors.white.withOpacity(0.04)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// TOP SECTION
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// ICON
                Container(
                  width: 52,
                  height: 52,

                  decoration: BoxDecoration(
                    color: const Color(0xff123645),

                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: const Icon(Icons.campaign, color: Color(0xff35D6FF)),
                ),

                const SizedBox(width: 12),

                /// TITLE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        campaign.name,

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),

                        decoration: BoxDecoration(
                          color: const Color(0xff123645),
                          borderRadius: BorderRadius.circular(6),
                        ),

                        child: Text(
                          campaign.objective,

                          style: const TextStyle(
                            color: Color(0xff35D6FF),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                /// STATUS
                Column(
                  children: [
                    StatusBadge(status: campaign.status),

                    const SizedBox(height: 8),

                    const Icon(Icons.more_horiz, color: Colors.white54),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// SPEND
            const Text(
              'Total spend',

              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Text(
                  '${campaign.spend.toStringAsFixed(0)} ${campaign.currency.toString()}',

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                Text(
                  ' / ${campaign.budget.toStringAsFixed(0)} ${campaign.currency.toString()}',

                  style: const TextStyle(color: Colors.white54, fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 14),

            /// PROGRESS
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: progress > 1 ? 1 : progress,

                      minHeight: 8,

                      backgroundColor: Colors.white12,

                      color: const Color(0xff35D6FF),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  '${campaign.budgetUtilization.toStringAsFixed(0)}%',

                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 22),

            /// METRICS
            Row(
              children: [
                Expanded(
                  child: _metricCard(
                    icon: Icons.remove_red_eye_outlined,
                    value: '${(campaign.impressions / 1000).toStringAsFixed(0)}K',
                    title: 'Impressions',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _metricCard(
                    icon: Icons.ads_click_outlined,
                    value: '${(campaign.clicks / 1000).toStringAsFixed(1)}K',
                    title: 'Clicks',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _metricCard(
                    icon: Icons.trending_up,
                    value: '${campaign.ctr.toStringAsFixed(2)}%',
                    title: 'CTR',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            /// FOOTER
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Color(0xff35D6FF),
                  size: 18,
                ),

                const SizedBox(width: 6),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Start date',

                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),

                    Text(
                      campaign.startDate,

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                const Icon(Icons.gps_fixed, color: Color(0xff35D6FF), size: 18),

                const SizedBox(width: 6),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Audience',

                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),

                    Text(
                      campaign.channel,

                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCard({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.white10),
      ),

      child: Column(
        children: [
          Icon(icon, color: const Color(0xff35D6FF), size: 18),

          const SizedBox(height: 8),

          Text(
            value,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,

            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
