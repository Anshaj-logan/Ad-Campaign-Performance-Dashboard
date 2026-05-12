import 'package:ad_campaign_performance_dashboard/bloc/campaign/campaign_bloc.dart';
import 'package:ad_campaign_performance_dashboard/bloc/campaign/campaign_event.dart';
import 'package:ad_campaign_performance_dashboard/bloc/campaign/campaign_state.dart';
import 'package:ad_campaign_performance_dashboard/injection_container.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/campaign_card.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/campaign_filter_bar.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/campaign_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class CampaignListPage extends StatelessWidget {
  const CampaignListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) =>
      sl<CampaignBloc>()
        ..add(FetchCampaignsEvent()),

      child: const CampaignListView(),
    );
  }
}

class CampaignListView extends StatefulWidget {
  const CampaignListView({super.key});

  @override
  State<CampaignListView> createState() =>
      _CampaignListViewState();
}

class _CampaignListViewState
    extends State<CampaignListView> {

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        title: const Text(
          'Campaign Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          /// FILTER BAR
          CampaignFilterBar(
            selectedFilter: selectedFilter,

            onSelected: (value) {

              setState(() {
                selectedFilter = value;
              });

              final bloc = context.read<CampaignBloc>();

              if (bloc.allCampaigns.isNotEmpty) {

                bloc.add(
                  FilterCampaignEvent(value),
                );
              }
            },
          ),

          /// LIST
          Expanded(
            child: BlocBuilder<
                CampaignBloc,
                CampaignState>(
              builder: (context, state) {

                /// LOADING
                if (state is CampaignLoading) {
                  return const CampaignShimmer();
                }

                /// ERROR
                if (state is CampaignError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                /// LOADED
                if (state is CampaignLoaded) {

                  if (state.campaigns.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Campaigns Found',
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {

                      context
                          .read<CampaignBloc>()
                          .add(
                        FetchCampaignsEvent(),
                      );
                    },

                    child: ListView.builder(
                      padding:
                      const EdgeInsets.all(16),

                      itemCount:
                      state.campaigns.length,

                      itemBuilder: (context, index) {

                        final campaign =
                        state.campaigns[index];

                        return Padding(
                          padding:
                          const EdgeInsets.only(
                            bottom: 16,
                          ),

                          child: CampaignCard(
                            campaign: campaign,
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}