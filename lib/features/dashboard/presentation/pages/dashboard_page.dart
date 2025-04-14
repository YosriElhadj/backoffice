import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../dashboard/presentation/widgets/dashboard_card.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../dashboard/presentation/pages/admin_scaffold.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Dashboard Overview',
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Key Performance Indicators
            Row(
              children: [
                DashboardCard(
                  title: 'Total Properties',
                  value: '124',
                  icon: Icons.real_estate_agent,
                  color: Colors.blue,
                ),
                DashboardCard(
                  title: 'Total Investors',
                  value: '3,452',
                  icon: Icons.people,
                  color: Colors.green,
                ),
                DashboardCard(
                  title: 'Total Investment',
                  value: '\$12.4M',
                  icon: Icons.money,
                  color: Colors.orange,
                ),
                DashboardCard(
                  title: 'New Investors',
                  value: '78',
                  icon: Icons.trending_up,
                  color: Colors.purple,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Charts
            Row(
              children: [
                // Investment Trends
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Investment Trends',
                            style: AppStyles.headline2.copyWith(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, 3),
                                    FlSpot(1, 2),
                                    FlSpot(2, 5),
                                    FlSpot(3, 3.5),
                                    FlSpot(4, 4),
                                    FlSpot(5, 4.5),
                                  ],
                                  isCurved: true,
                                  color: AppColors.primary,
                                  barWidth: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Property Distribution
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Property Distribution',
                            style: AppStyles.headline2.copyWith(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                              sections: [
                                PieChartSectionData(
                                  color: Colors.blue,
                                  value: 40,
                                  title: 'Residential',
                                  radius: 50,
                                ),
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: 30,
                                  title: 'Commercial',
                                  radius: 50,
                                ),
                                PieChartSectionData(
                                  color: Colors.orange,
                                  value: 20,
                                  title: 'Agricultural',
                                  radius: 50,
                                ),
                                PieChartSectionData(
                                  color: Colors.purple,
                                  value: 10,
                                  title: 'Industrial',
                                  radius: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}