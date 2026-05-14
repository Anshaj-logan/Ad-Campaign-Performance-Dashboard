import 'package:ad_campaign_performance_dashboard/bloc/campaign_detail/campaign_detail_bloc.dart';
import 'package:ad_campaign_performance_dashboard/bloc/campaign_detail/campaign_detail_event.dart';
import 'package:ad_campaign_performance_dashboard/bloc/campaign_detail/campaign_detail_state.dart';
import 'package:ad_campaign_performance_dashboard/domain/entities/campaign_entity.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class CampaignDetailPage extends StatelessWidget {
  final CampaignEntity campaign;

  const CampaignDetailPage({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CampaignDetailBloc>()
        ..add(
          FetchCampaignHistoryEvent(
            campaign.id,
          ),
        ),

      child: Scaffold(
        backgroundColor: const Color(0xff0B0D16),

        body: SafeArea(
          child: BlocBuilder<
              CampaignDetailBloc,
              CampaignDetailState>(
            builder: (context, state) {

              if (state is CampaignDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CampaignDetailError) {
                return Center(
                  child: Text(
                    state.message,

                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              if (state is CampaignDetailLoaded) {

                final lastHistoricalCtr =
                    state.history.last.ctr;

                final lastForecastCtr =
                    state.forecast.last.predictedCtr;

                final ctrGrowthPercent =
                    ((lastForecastCtr -
                        lastHistoricalCtr) /
                        lastHistoricalCtr) *
                        100;

                final isPositive =
                    ctrGrowthPercent >= 0;

                final recommendationText =
                isPositive
                    ? 'Consider increasing budget to maximize results'
                    : 'Consider reducing spend and optimizing creatives';

                final forecastMessage =
                isPositive
                    ? 'CTR is predicted to increase by ${ctrGrowthPercent.abs().toStringAsFixed(1)}% ↗'
                    : 'CTR may decrease by ${ctrGrowthPercent.abs().toStringAsFixed(1)}% ↘';
                return ListView(
                  padding: const EdgeInsets.all(16),

                  children: [

                    /// HEADER
                    Row(
                      children: [

                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                campaign.name,

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Row(
                                children: [

                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.green
                                          .withOpacity(0.18),

                                      borderRadius:
                                      BorderRadius.circular(6),
                                    ),

                                    child: const Text(
                                      'Active',

                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.cyan
                                          .withOpacity(0.18),

                                      borderRadius:
                                      BorderRadius.circular(6),
                                    ),

                                    child: const Text(
                                      'Conversion',

                                      style: TextStyle(
                                        color: Colors.cyan,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// KPI CARDS
                    Row(
                      children: [

                        Expanded(
                          child: _metricCard(
                            value: '${(campaign.impressions / 1000).toStringAsFixed(0)}K',
                            title: 'Impressions',
                            icon: Icons.remove_red_eye,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _metricCard(
                            value: '${(campaign.clicks / 1000).toStringAsFixed(1)}K',
                            title: 'Clicks',
                            icon: Icons.ads_click,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _metricCard(
                            value:
                            '${campaign.ctr.toStringAsFixed(2)}%',
                            title: 'CTR',
                            icon: Icons.trending_up,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _metricCard(
                            value: '${campaign.spend.toStringAsFixed(0)} ${campaign.currency.toString()}',
                            title: 'Total Spend',
                            icon: Icons.payments,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// CHART CARD
                    Container(
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: const Color(0xff1A1C29),

                        borderRadius:
                        BorderRadius.circular(18),
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          /// TITLE
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                            children: [

                              Row(
                                children: [

                                  const Text(
                                    'CTR Performance & Forecast',

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(width: 6),

                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white54,
                                    size: 16,
                                  ),
                                ],
                              ),

                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white10,
                                  ),

                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),

                                child: const Row(
                                  children: [

                                    Text(
                                      '30 Days',

                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 11,
                                      ),
                                    ),

                                    SizedBox(width: 4),

                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white54,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// LEGENDS
                          Row(
                            children: [

                              Container(
                                width: 14,
                                height: 2,
                                color:
                                const Color(0xff00D1FF),
                              ),

                              const SizedBox(width: 6),

                              const Text(
                                'Historical CTR',

                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(width: 16),

                              Container(
                                width: 14,
                                height: 2,
                                color: Colors.white70,
                              ),

                              const SizedBox(width: 6),

                              const Text(
                                'Forecast CTR',

                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            height: 260,

                            child: LineChart(
                              LineChartData(

                                minY: 2,
                                maxY: 6,

                                gridData: FlGridData(
                                  show: true,

                                  drawVerticalLine: true,

                                  horizontalInterval: 1,

                                  verticalInterval: 5,

                                  getDrawingHorizontalLine:
                                      (value) {
                                    return FlLine(
                                      color: Colors.white10,
                                      strokeWidth: 1,
                                    );
                                  },

                                  getDrawingVerticalLine:
                                      (value) {
                                    return FlLine(
                                      color: Colors.white10,
                                      strokeWidth: 1,

                                      dashArray: [6, 6],
                                    );
                                  },
                                ),

                                borderData:
                                FlBorderData(show: false),

                                titlesData: FlTitlesData(

                                  topTitles:
                                  const AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),

                                  rightTitles:
                                  const AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                  ),

                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,

                                      interval: 1,

                                      reservedSize: 32,

                                      getTitlesWidget:
                                          (value, meta) {

                                        return Text(
                                          '${value.toInt()}%',

                                          style:
                                          const TextStyle(
                                            color:
                                            Colors.white54,
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,

                                      interval: 5,

                                      getTitlesWidget:
                                          (value, meta) {

                                        final index =
                                        value.toInt();

                                        if (index >=
                                            state.history.length) {
                                          return const SizedBox();
                                        }

                                        final date =
                                            state.history[index].date;

                                        final day =
                                            date.split('-').last;

                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            top: 8,
                                          ),

                                          child: Text(
                                            day,

                                            style:
                                            const TextStyle(
                                              color:
                                              Colors.white54,
                                              fontSize: 10,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                extraLinesData:
                                ExtraLinesData(
                                  verticalLines: [

                                    VerticalLine(
                                      x:
                                      state.history.length - 1,

                                      color: Colors.white24,

                                      strokeWidth: 1,

                                      dashArray: [6, 6],
                                    ),
                                  ],
                                ),

                                lineBarsData: [

                                  /// HISTORICAL
                                  LineChartBarData(

                                    spots: state.history
                                        .asMap()
                                        .entries
                                        .map((e) {

                                      return FlSpot(
                                        e.key.toDouble(),

                                        e.value.ctr * 100,
                                      );

                                    }).toList(),

                                    isCurved: true,

                                    color:
                                    const Color(0xff00D1FF),

                                    barWidth: 3,

                                    dotData:
                                    const FlDotData(
                                      show: false,
                                    ),

                                    belowBarData:
                                    BarAreaData(
                                      show: true,

                                      color:
                                      const Color(
                                        0xff00D1FF,
                                      ).withOpacity(0.12),
                                    ),
                                  ),

                                  /// FORECAST
                                  LineChartBarData(

                                    spots: state.forecast
                                        .asMap()
                                        .entries
                                        .map((e) {

                                      return FlSpot(
                                        (
                                            state.history.length +
                                                e.key
                                        ).toDouble(),

                                        e.value.predictedCtr * 100,
                                      );

                                    }).toList(),

                                    isCurved: true,

                                    color: Colors.white70,

                                    barWidth: 3,

                                    dashArray: [8, 4],

                                    dotData:
                                    const FlDotData(
                                      show: false,
                                    ),

                                    belowBarData:
                                    BarAreaData(
                                      show: true,

                                      color: Colors.white
                                          .withOpacity(0.05),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// RECOMMENDATION CARD
                    /// RECOMMENDATION CARD
                    Container(

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(

                        color: const Color(0xff1A1C29),

                        borderRadius:
                        BorderRadius.circular(16),
                      ),

                      child: Row(

                        children: [

                          Container(

                            padding:
                            const EdgeInsets.all(14),

                            decoration: BoxDecoration(

                              color: isPositive
                                  ? Colors.green.withOpacity(0.15)
                                  : Colors.orange.withOpacity(0.15),

                              borderRadius:
                              BorderRadius.circular(12),
                            ),

                            child: Icon(

                              isPositive
                                  ? Icons.trending_up
                                  : Icons.trending_down,

                              color: isPositive
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                Text(

                                  'Budget Recommendation',

                                  style: TextStyle(

                                    color: isPositive
                                        ? Colors.green
                                        : Colors.orange,

                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(

                                  forecastMessage,

                                  style: const TextStyle(

                                    color: Colors.white,

                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(

                                  recommendationText,

                                  style: const TextStyle(

                                    color: Colors.white54,

                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(

                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),

                            decoration: BoxDecoration(

                              border: Border.all(

                                color: isPositive
                                    ? Colors.green
                                    : Colors.orange,
                              ),

                              borderRadius:
                              BorderRadius.circular(8),
                            ),

                            child: Text(

                              'View Details',

                              style: TextStyle(

                                color: isPositive
                                    ? Colors.green
                                    : Colors.orange,

                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  static Widget _metricCard({
    required String value,
    required String title,
    required IconData icon,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: const Color(0xff1A1C29),

        borderRadius:
        BorderRadius.circular(12),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: const Color(0xff00D1FF),
            size: 15,
          ),

          const SizedBox(height: 10),

          Text(
            value,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}