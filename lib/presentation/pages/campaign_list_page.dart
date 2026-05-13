import 'package:ad_campaign_performance_dashboard/bloc/campaign/campaign_bloc.dart';
import 'package:ad_campaign_performance_dashboard/bloc/campaign/campaign_event.dart';
import 'package:ad_campaign_performance_dashboard/bloc/campaign/campaign_state.dart';
import 'package:ad_campaign_performance_dashboard/injection_container.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/campaign_card.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/campaign_filter_bar.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/campaign_shimmer.dart';
import 'package:ad_campaign_performance_dashboard/presentation/widgets/search_bar_widget.dart';
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

      backgroundColor: const Color(0xff0F111A),

      appBar: AppBar(

        backgroundColor: const Color(0xff0F111A),

        elevation: 0,

        title: const Text(
          'Campaign List',

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          onPressed: () {},

          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [

          /// SEARCH BAR
          const SearchBarWidget(),

          /// FILTERS
          CampaignFilterBar(
            selectedFilter: selectedFilter,

            onSelected: (value) {

              setState(() {
                selectedFilter = value;
              });

              final bloc =
              context.read<CampaignBloc>();

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

                if (state is CampaignLoading) {
                  return const CampaignShimmer();
                }

                if (state is CampaignError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                if (state is CampaignLoaded) {

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