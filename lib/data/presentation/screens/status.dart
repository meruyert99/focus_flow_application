class StatsScreen extends StatelessWidget {
    // Берём начало урока как минимальный timestamp
    final start = list.map((e) => e.timestamp).reduce((a, b) => a.isBefore(b) ? a : b);

    for (var a in list) {
      final diffMin = a.timestamp.difference(start).inMinutes;
      final bucket = diffMin ~/ minutes; // номер интервала
      buckets[bucket] = (buckets[bucket] ?? 0) + 1;
    }

    return buckets;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByInterval(activities, minutes: 5);

    final spots = grouped.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
        .toList()
      ..sort((a, b) => a.x.compareTo(b.x));

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Over Time')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: spots.isEmpty
            ? const Center(child: Text('No data yet'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Activity (every 5 minutes)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text('${value.toInt() * 5}m');
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            spots: spots,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
