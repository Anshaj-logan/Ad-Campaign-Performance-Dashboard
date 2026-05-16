import 'package:ad_campaign_performance_dashboard/bloc/alert/alert_bloc.dart';
import 'package:ad_campaign_performance_dashboard/bloc/alert/alert_event.dart';
import 'package:ad_campaign_performance_dashboard/bloc/alert/alert_state.dart';
import 'package:ad_campaign_performance_dashboard/data/services/notification_service.dart';
import 'package:ad_campaign_performance_dashboard/injection_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AnomalyAlertPage extends StatefulWidget {

  const AnomalyAlertPage({
    super.key,
  });

  @override
  State<AnomalyAlertPage> createState() =>
      _AnomalyAlertPageState();
}

class _AnomalyAlertPageState
    extends State<AnomalyAlertPage> {

  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (_) =>
      sl<AlertBloc>()
        ..add(FetchAlertsEvent()),

      child: Scaffold(

        backgroundColor:
        const Color(0xff0B0D16),

        body: SafeArea(

          child: BlocBuilder<
              AlertBloc,
              AlertState>(

            builder: (context, state) {

              /// LOADING
              if (state is AlertLoading) {

                return const Center(
                  child:
                  CircularProgressIndicator(),
                );
              }

              /// ERROR
              if (state is AlertError) {

                return Center(

                  child: Text(

                    state.message,

                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }

              /// LOADED
              if (state is AlertLoaded) {

                return ListView(

                  padding:
                  const EdgeInsets.all(16),

                  children: [

                    /// TITLE
                    const Text(
                      'Anomaly Alerts',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// LIVE MONITOR CARD
                    Container(

                      padding:
                      const EdgeInsets.all(18),

                      decoration: BoxDecoration(

                        color:
                        const Color(0xff1A1C29),

                        borderRadius:
                        BorderRadius.circular(
                          22,
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

                              color: const Color(
                                0xff00D1FF,
                              ).withOpacity(
                                0.12,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                            ),

                            child: const Icon(
                              Icons.monitor_heart,
                              color:
                              Color(0xff00D1FF),
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 16),

                          const Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                Text(
                                  'Monitoring in real-time',

                                  style: TextStyle(
                                    color:
                                    Colors.white,

                                    fontWeight:
                                    FontWeight
                                        .bold,

                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  'Polling Ads API every 30 seconds',

                                  style: TextStyle(
                                    color:
                                    Colors.white54,

                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Row(

                            children: [

                              CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                Colors.green,
                              ),

                              SizedBox(width: 8),

                              Text(
                                'Live',

                                style: TextStyle(
                                  color:
                                  Colors.green,

                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// HEADER
                    const Text(
                      'Recent Anomalies',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// ALERT LIST
                    ...state.anomalies.map((e) {

                      final isSpendSpike =
                          e.type ==
                              'spend_spike';

                      final typeText =
                      isSpendSpike
                          ? 'Spend Spike'
                          : 'CTR Drop';

                      return Container(

                        margin:
                        const EdgeInsets.only(
                          bottom: 18,
                        ),

                        padding:
                        const EdgeInsets.all(
                          16,
                        ),

                        decoration: BoxDecoration(

                          color:
                          const Color(
                            0xff1A1C29,
                          ),

                          borderRadius:
                          BorderRadius.circular(
                            22,
                          ),
                        ),

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [

                            /// TOP
                            Row(

                              children: [

                                Container(

                                  padding:
                                  const EdgeInsets
                                      .all(12),

                                  decoration:
                                  BoxDecoration(

                                    color:
                                    isSpendSpike
                                        ? Colors.red
                                        .withOpacity(
                                      0.15,
                                    )
                                        : Colors.orange
                                        .withOpacity(
                                      0.15,
                                    ),

                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      14,
                                    ),
                                  ),

                                  child: Icon(

                                    isSpendSpike
                                        ? Icons
                                        .trending_up
                                        : Icons
                                        .trending_down,

                                    color:
                                    isSpendSpike
                                        ? Colors.red
                                        : Colors.orange,
                                  ),
                                ),

                                const SizedBox(
                                  width: 14,
                                ),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      Container(

                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                          horizontal:
                                          8,
                                          vertical:
                                          4,
                                        ),

                                        decoration:
                                        BoxDecoration(

                                          color:
                                          isSpendSpike
                                              ? Colors.red
                                              .withOpacity(
                                            0.15,
                                          )
                                              : Colors.orange
                                              .withOpacity(
                                            0.15,
                                          ),

                                          borderRadius:
                                          BorderRadius.circular(
                                            6,
                                          ),
                                        ),

                                        child: Text(

                                          typeText,

                                          style:
                                          TextStyle(
                                            color:
                                            isSpendSpike
                                                ? Colors.red
                                                : Colors.orange,

                                            fontSize:
                                            11,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 8,
                                      ),

                                      Text(
                                        e.campaignName,

                                        style:
                                        const TextStyle(
                                          color:
                                          Colors.white,

                                          fontSize:
                                          20,

                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 4,
                                      ),

                                      const Text(
                                        'Campaign',

                                        style:
                                        TextStyle(
                                          color:
                                          Colors.white38,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Text(
                                  '2m ago',

                                  style: TextStyle(
                                    color:
                                    Colors.white38,

                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            /// MESSAGE
                            Text(

                              e.message,

                              style:
                              const TextStyle(
                                color:
                                Colors.white,

                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            /// METRICS
                            Row(

                              children: [

                                Expanded(
                                  child:
                                  _metricBox(

                                    isSpendSpike
                                        ? '${e.actualValue.toStringAsFixed(0)} SAR'
                                        : '${e.actualValue.toStringAsFixed(1)}%',

                                    'Spend',
                                  ),
                                ),

                                const SizedBox(
                                  width: 12,
                                ),

                                Expanded(
                                  child:
                                  _metricBox(

                                    isSpendSpike
                                        ? '${e.expectedValue.toStringAsFixed(0)} SAR'
                                        : '${e.expectedValue.toStringAsFixed(1)}%',

                                    'Expected',
                                  ),
                                ),

                                const SizedBox(
                                  width: 12,
                                ),

                                Expanded(
                                  child:
                                  _metricBox(

                                    '${e.deviationPercent.toStringAsFixed(0)}%',

                                    'Change',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),

                    /// PUSH NOTIFICATION CARD
                    Container(

                      padding:
                      const EdgeInsets.all(
                        18,
                      ),

                      decoration: BoxDecoration(

                        color:
                        const Color(
                          0xff1A1C29,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          22,
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

                              color:
                              const Color(
                                0xff00D1FF,
                              ).withOpacity(
                                0.15,
                              ),

                              borderRadius:
                              BorderRadius.circular(
                                16,
                              ),
                            ),

                            child: const Icon(
                              Icons.notifications,
                              color:
                              Color(0xff00D1FF),
                            ),
                          ),

                          const SizedBox(width: 16),

                          const Expanded(

                            child: Column(

                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                              children: [

                                Text(
                                  'Enable Push Notifications',

                                  style: TextStyle(
                                    color:
                                    Colors.white,

                                    fontWeight:
                                    FontWeight
                                        .bold,

                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  'Get notified instantly when anomalies are detected.',

                                  style: TextStyle(
                                    color:
                                    Colors.white54,

                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Switch(

                            value:
                            isNotificationEnabled,

                            activeColor:
                            const Color(
                              0xff00D1FF,
                            ),

                            onChanged: (value) {

                              setState(() {

                                isNotificationEnabled =
                                    value;
                              });

                              sl<NotificationService>()
                                  .toggleNotifications(
                                value,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
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

  Widget _metricBox(
      String value,
      String title,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 16,
      ),

      decoration: BoxDecoration(

        border: Border.all(
          color: Colors.white10,
        ),

        borderRadius:
        BorderRadius.circular(
          14,
        ),
      ),

      child: Column(

        children: [

          Text(
            value,

            style: const TextStyle(
              color: Colors.white,

              fontWeight:
              FontWeight.bold,

              fontSize: 15,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,

            style: const TextStyle(
              color: Colors.white54,

              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}