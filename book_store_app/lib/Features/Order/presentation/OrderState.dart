import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<dynamic> orders;

  const OrderLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderCreated extends OrderState {
  final Map<String, dynamic> order;

  const OrderCreated(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderCancelled extends OrderState {
  final String orderId;

  const OrderCancelled(this.orderId);

  @override
  List<Object?> get props => [orderId];
} 