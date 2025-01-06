import 'package:equatable/equatable.dart';

abstract class SeatSelectionEvent extends Equatable {
  const SeatSelectionEvent();

  @override
  List<Object?> get props => [];
}

class SelectSeat extends SeatSelectionEvent {
  final String seat;
  final String row;
  final double price;

  const SelectSeat({required this.seat, required this.row, required this.price});

  @override
  List<Object?> get props => [seat, row, price];
}

class ZoomIn extends SeatSelectionEvent {}

class ZoomOut extends SeatSelectionEvent {}

class ResetSelection extends SeatSelectionEvent {}
