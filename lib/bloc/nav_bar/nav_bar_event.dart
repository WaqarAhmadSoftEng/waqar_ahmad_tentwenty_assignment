import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeScreenIndex extends NavigationEvent {
  final int newIndex;

  ChangeScreenIndex(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
