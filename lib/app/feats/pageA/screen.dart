import 'package:flutter/material.dart';
import 'package:flutter_readable/flutter_readable.dart';
import 'package:safe_tester/app/core/components/center_loading.dart';
import 'package:safe_tester/app/core/components/main_card.dart';
import 'package:safe_tester/app/core/providers/order_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = OrdersNotifier.of(context);
    return notifier.value.map(
      loading: () => const CenterLoading(),
      error: (error) => Center(child: Text(error)),
      data: (orders) => ListView(
        primary: true,
        children: [
          MainCard(
            child: Center(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Last Week'),
                    trailing: const Text(
                      '+ 3.5%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${orders.length}',
                          style: context.textTheme.displayLarge,
                        ),
                        TextSpan(
                          text: '\nThis week\'s orders',
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          MainCard(
            child: Center(
              child: SfCircularChart(
                  title: ChartTitle(
                    text: 'Order Status Distribution',
                    textStyle: TextStyle(fontSize: 24),
                  ),
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                    PieSeries<OrderCount, String>(
                      dataSource: notifier.orderStatusCount,
                      explode: true,
                      xValueMapper: (data, _) => data.$1.name,
                      yValueMapper: (data, _) => data.$2,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ]),
            ),
          ),
          MainCard(
            child: Center(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Last Week'),
                    trailing: const Text(
                      '- 12.4%',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: r'$' +
                              orders
                                  .map((e) => e.priceValue)
                                  .average()
                                  .toStringAsFixed(2),
                          style: context.textTheme.displayLarge,
                        ),
                        TextSpan(
                          text: '\nThis week\'s Average Price',
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
