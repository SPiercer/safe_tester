import 'package:safe_tester/app/core/models/order_status.dart';

class Order {
  final String id;
  final bool isActive;
  final String price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final String status;
  final String registered;

  double get priceValue =>
      double.parse(price.replaceAll(RegExp(r'[^\d.]'), ''));

  OrderStatus get orderStatus =>
      OrderStatus.values.byName(status.toLowerCase());

  DateTime get registeredDate => DateTime.parse(registered);

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      isActive: json['isActive'],
      price: json['price'],
      company: json['company'],
      picture: json['picture'],
      buyer: json['buyer'],
      tags: List<String>.from(json['tags']),
      status: json['status'],
      registered: json['registered'],
    );
  }
}
