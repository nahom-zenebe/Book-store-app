import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserOrders extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> shippingAddress;
  final String paymentMethod;

  const CreateOrder({
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [items, shippingAddress, paymentMethod];
}

class GetOrderById extends OrderEvent {
  final String orderId;

  const GetOrderById(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class CancelOrder extends OrderEvent {
  final String orderId;

  const CancelOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
} 