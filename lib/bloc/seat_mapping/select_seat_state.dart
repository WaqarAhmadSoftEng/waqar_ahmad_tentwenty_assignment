import 'package:equatable/equatable.dart';

class SeatSelectionState extends Equatable {
  final String selectedSeat;
  final String selectedRow;
  final double totalPrice;
  final double zoomLevel;

  const SeatSelectionState({
    this.selectedSeat = '',
    this.selectedRow = '',
    this.totalPrice = 0.0,
    this.zoomLevel = 1.0,
  });

  SeatSelectionState copyWith({
    String? selectedSeat,
    String? selectedRow,
    double? totalPrice,
    double? zoomLevel,
  }) {
    return SeatSelectionState(
      selectedSeat: selectedSeat ?? this.selectedSeat,
      selectedRow: selectedRow ?? this.selectedRow,
      totalPrice: totalPrice ?? this.totalPrice,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  @override
  List<Object?> get props => [selectedSeat, selectedRow, totalPrice, zoomLevel];
}
