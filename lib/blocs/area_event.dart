part of 'area_bloc.dart';

@immutable
abstract class AreaEvent {}

class AreaLoadedEvent extends AreaEvent {}

class AreaClickEvent extends AreaEvent {
  final String key;
  final int clickIndex;
  AreaClickEvent(this.key, this.clickIndex);
}
class NavigateToNextPageEvent extends AreaEvent {}