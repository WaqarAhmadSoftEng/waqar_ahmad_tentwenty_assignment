import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int screenIndex;
  final String hashTag;

  const NavigationState({this.screenIndex = 0, this.hashTag = ''});

  NavigationState copyWith({int? screenIndex, String? hashTag}) {
    return NavigationState(
      screenIndex: screenIndex ?? this.screenIndex,
      hashTag: hashTag ?? this.hashTag,
    );
  }

  @override
  List<Object> get props => [screenIndex, hashTag];
}
