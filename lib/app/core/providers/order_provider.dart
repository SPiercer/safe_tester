import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:safe_tester/app/core/models/order.dart';
import 'package:safe_tester/app/core/models/order_status.dart';
import 'package:signals_flutter/signals_flutter.dart';

typedef OrderCount = (OrderStatus status, int count);
typedef OrderTime = (DateTime time, int count);

class OrdersNotifier extends FlutterSignal<AsyncState<List<Order>>> {
  OrdersNotifier() : super(AsyncState.loading()) {
    loadOrders();
  }

  static OrdersNotifier of(BuildContext context, {bool listen = true}) =>
      SignalProvider.of(context, listen: listen)!;

  List<OrderCount> get orderStatusCount {
    final orders = value.value;
    if (orders == null) return [];
    return OrderStatus.values
        .map((status) => (
              status,
              orders.where((order) => order.orderStatus == status).length
            ))
        .toList();
  }

  List<OrderTime> get orderTimeCount {
    final orders = value.value;
    if (orders == null) return [];
    return orders
        .map((order) => (order.registeredDate, orders.length))
        .toList();
  }

  Future<void> loadOrders() async {
    try {
      final orders = await _fetchOrders();
      value = AsyncState.data(orders);
    } catch (e) {
      value = AsyncState.error(e);
    }
  }

  Future<List<Order>> _fetchOrders() async {
    final data = await rootBundle.loadString('assets/orders.json');
    final List<dynamic> json = jsonDecode(data);
    return json.map((e) => Order.fromJson(e)).toList();
  }
}
