import 'package:ad_campaign_performance_dashboard/bloc/summary/summary_bloc.dart';
import 'package:ad_campaign_performance_dashboard/bloc/summary/summary_event.dart';
import 'package:ad_campaign_performance_dashboard/bloc/summary/summary_state.dart';
import 'package:ad_campaign_performance_dashboard/injection_container.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class SpendSummaryPage
    extends StatelessWidget {

  const SpendSummaryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) =>
      sl<SummaryBloc>()
        ..add(
          FetchSummaryEvent(
            'last_7_days',
          ),
        ),

      child: Scaffold(

        backgroundColor:
        const Color(0xff0B0D16),

        body: SafeArea(

          child: BlocBuilder<
              SummaryBloc,
              SummaryState>(

            builder: (context, state) {

              if (state
              is SummaryLoading) {

                return const Center(
                  child:
                  CircularProgressIndicator(),
                );
              }

              if (state
              is SummaryLoaded) {

                final summary =
                    state.summary;

                return ListView(

                  padding:
                  const EdgeInsets.all(16),

                  children: [

                    /// TITLE
                    const Text(
                      'Spend Summary',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),


                    Container(

                      padding:
                      const EdgeInsets.all(18),

                      decoration: BoxDecoration(

                        color:
                        const Color(
                          0xff1A1C29,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Row(

                        children: [

                          Container(

                            padding:
                            const EdgeInsets.all(
                              14,
                            ),

                            decoration: BoxDecoration(

                              color: Colors.green
                                  .withOpacity(
                                0.15,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                12,
                              ),
                            ),

                            child: const Icon(
                              Icons.trending_up,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Column(

                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              const Text(
                                'Total Spend',

                                style: TextStyle(
                                  color:
                                  Colors.white54,
                                ),
                              ),

                              const SizedBox(
                                height: 6,
                              ),

                              Text(
                                '${summary.totalSpend.toStringAsFixed(0)} SAR',

                                style:
                                const TextStyle(
                                  color:
                                  Colors.white,

                                  fontSize: 20,

                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// DONUT CHART
                    Container(

                      padding:
                      const EdgeInsets.all(16),

                      decoration: BoxDecoration(

                        color:
                        const Color(
                          0xff1A1C29,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          const Text(
                            'Spend by channel',

                            style: TextStyle(
                              color:
                              Colors.white,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(

                            height: 130,

                            child: Row(

                              children: [

                                Expanded(

                                  child:
                                  PieChart(

                                    PieChartData(

                                      centerSpaceRadius:
                                      38,

                                      sectionsSpace:
                                      3,

                                      sections: [

                                        PieChartSectionData(
                                          value:
                                          summary
                                              .byChannel[0]
                                              .spend,

                                          color:
                                          Colors.cyan,

                                          radius: 18,

                                          title: '',
                                        ),

                                        PieChartSectionData(
                                          value:
                                          summary
                                              .byChannel[1]
                                              .spend,

                                          color:
                                          Colors.blue,

                                          radius: 18,

                                          title: '',
                                        ),

                                        PieChartSectionData(
                                          value:
                                          summary
                                              .byChannel[2]
                                              .spend,

                                          color:
                                          Colors.purple,

                                          radius: 18,

                                          title: '',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 20),

                                Expanded(

                                  child: Column(

                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,

                                    children: [

                                      _legendItem(
                                        color:
                                        Colors.cyan,
                                        title:
                                        'Search',
                                        percent:
                                        '40%',
                                      ),

                                      _legendItem(
                                        color:
                                        Colors.blue,
                                        title:
                                        'Social',
                                        percent:
                                        '35%',
                                      ),

                                      _legendItem(
                                        color:
                                        Colors.purple,
                                        title:
                                        'Display',
                                        percent:
                                        '25%',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// TOP CAMPAIGNS
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

                          const Text(

                            'Top 3 Campaigns by CTR',

                            style: TextStyle(

                              color: Colors.white,

                              fontSize: 18,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 18),

                          ...summary.topCampaigns
                              .asMap()
                              .entries
                              .map((e) {

                            final campaign =
                                e.value;

                            return Column(

                              children: [

                                Row(

                                  children: [

                                    Container(

                                      width: 26,
                                      height: 26,

                                      alignment:
                                      Alignment.center,

                                      decoration:
                                      BoxDecoration(

                                        color: const Color(
                                          0xff00D1FF,
                                        ).withOpacity(0.15),

                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                          6,
                                        ),
                                      ),

                                      child: Text(

                                        '${e.key + 1}',

                                        style:
                                        const TextStyle(

                                          color: Color(
                                            0xff00D1FF,
                                          ),

                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(

                                      child: Text(

                                        campaign.name,

                                        style:
                                        const TextStyle(

                                          color:
                                          Colors.white,

                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,

                                      children: [

                                        Text(
                                          '${(campaign.ctr * 100).toStringAsFixed(1)}%',

                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(width: 4),

                                        const Icon(
                                          Icons.arrow_outward,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                if (e.key != 2)
                                  Padding(

                                    padding:
                                    const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),

                                    child: Divider(
                                      color: Colors.white10,
                                    ),
                                  ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// DATE RANGE
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

                          const Text(

                            'Date Range',

                            style: TextStyle(

                              color: Colors.white,

                              fontSize: 18,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(

                            children: [

                              Expanded(
                                child: _rangeButton(
                                  context,
                                  title: 'Last 7 Days',
                                  value: 'last_7_days',
                                  selected:
                                  context
                                      .read<
                                      SummaryBloc>()
                                      .selectedRange ==
                                      'last_7_days',
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _rangeButton(
                                  context,
                                  title: 'Last 14 Days',
                                  value: 'last_14_days',
                                  selected:
                                  context
                                      .read<
                                      SummaryBloc>()
                                      .selectedRange ==
                                      'last_14_days',
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _rangeButton(
                                  context,
                                  title: 'Last 30 Days',
                                  value: 'last_30_days',
                                  selected:
                                  context
                                      .read<
                                      SummaryBloc>()
                                      .selectedRange ==
                                      'last_30_days',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

  static Widget _legendItem({

    required Color color,

    required String title,

    required String percent,

  }) {

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom: 18,
      ),

      child: Row(

        children: [

          Container(
            width: 12,
            height: 12,

            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),

          Text(
            percent,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  static Widget _rangeButton(

      BuildContext context, {

        required String title,

        required String value,

        required bool selected,

      }) {

    return GestureDetector(

      onTap: () {

        context.read<SummaryBloc>().add(
          FetchSummaryEvent(value),
        );
      },

      child: Container(

        padding:
        const EdgeInsets.symmetric(
          vertical: 12,
        ),

        alignment: Alignment.center,

        decoration: BoxDecoration(

          color: selected
              ? const Color(
            0xff00D1FF,
          ).withOpacity(0.12)
              : Colors.transparent,

          border: Border.all(

            color: selected
                ? const Color(
              0xff00D1FF,
            )
                : Colors.white12,
          ),

          borderRadius:
          BorderRadius.circular(10),
        ),

        child: Text(

          title,

          style: TextStyle(

            color: selected
                ? const Color(
              0xff00D1FF,
            )
                : Colors.white54,

            fontSize: 12,

            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}