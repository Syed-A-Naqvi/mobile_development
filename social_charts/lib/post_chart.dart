import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'post.dart';


class PostChart extends StatelessWidget {

  final List<Post> data;

  const PostChart({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(minimum: 0, maximum: 100, interval: 25),
      title: const ChartTitle(text: "Upvotes vs Downvotes"),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      // tooltipBehavior: _tooltip,
      series: <CartesianSeries>[
        // Series for Upvotes
        BarSeries<Post, String>(
          dataSource: data,
          xValueMapper: (Post post, _) => post.title,
          yValueMapper: (Post post, _) => post.numUpVotes,
          name: 'Upvotes',
          color: Colors.green,
        ),
        // Series for Downvotes
        BarSeries<Post, String>(
          dataSource: data,
          xValueMapper: (Post post, _) => post.title,
          yValueMapper: (Post post, _) => post.numDownVotes,
          name: 'Downvotes',
          color: Colors.red,
        ),
      ]
    );
  }
}