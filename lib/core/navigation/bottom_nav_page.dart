import 'package:ad_campaign_performance_dashboard/presentation/pages/anomaly_alert_page.dart';
import 'package:ad_campaign_performance_dashboard/presentation/pages/campaign_list_page.dart';
import 'package:ad_campaign_performance_dashboard/presentation/pages/spend_summary_page.dart';
import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  final pages = [
    const CampaignListPage(),
    const SpendSummaryPage(),
    const AnomalyAlertPage(),
    const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        backgroundColor: const Color(0xff121212),

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xff35D6FF),

        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            label: 'Campaigns',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Spend Summary',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Alerts',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
