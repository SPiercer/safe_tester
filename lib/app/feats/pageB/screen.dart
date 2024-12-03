import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safe_tester/app/core/components/center_loading.dart';
import 'package:safe_tester/app/core/providers/order_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = OrdersNotifier.of(context);
    return notifier.value.map(
      loading: () => const CenterLoading(),
      error: (error) => Center(child: Text(error)),
      data: (orders) {
        return SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            enableDoubleTapZooming: true,
            zoomMode: ZoomMode.x,
          ),
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.months,
            dateFormat: DateFormat.yMMM(),
            autoScrollingDelta: 100,
            autoScrollingDeltaType: DateTimeIntervalType.months,
          ),
          legend: Legend(isVisible: true),
          series: [
            ColumnSeries<OrderTime, DateTime>(
              legendItemText: 'Orders over time',
              dataSource: notifier.orderTimeCount.take(10).toList(),
              xValueMapper: (data, _) => data.$1,
              yValueMapper: (data, _) => orders
                  .take(10)
                  .toList()
                  .where((order) => order.registeredDate.isBefore(data.$1))
                  .length,
            ),
          ],
        );
        // Calculate cumulative orders per month
      },
    );
  }
}
