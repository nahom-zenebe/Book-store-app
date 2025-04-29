import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
  Widget buildCard(String title, String count) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color.fromARGB(255, 5, 116, 11),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              count,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCard("Total Users", "30"),
                  const SizedBox(width: 10),
                  buildCard("Active Users", "25"),
                  const SizedBox(width: 10),
                  buildCard("New Signups", "5"),
                  const SizedBox(width: 10),
                  buildCard("Pending Requests", "2"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}







class AdminGraphDashboard extends StatelessWidget {
  const AdminGraphDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Graph Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "User Growth Over Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 200, child: LineChartWidget()),
            const SizedBox(height: 30),
            const Text(
              "Monthly Signups",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 200, child: BarChartWidget()),
          ],
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 2),
              FlSpot(1, 3),
              FlSpot(2, 6),
              FlSpot(3, 5),
              FlSpot(4, 8),
            ],
            isCurved: true,
            barWidth: 4,
            color: Colors.blue,
            dotData: FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text("Q${value.toInt() + 1}"),
            ),
          ),
        ),
        gridData: FlGridData(show: true),
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: 5, color: Colors.green, width: 20),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 8, color: Colors.green, width: 20),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 6, color: Colors.green, width: 20),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 9, color: Colors.green, width: 20),
          ]),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr'];
                return Text(months[value.toInt()]);
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}





