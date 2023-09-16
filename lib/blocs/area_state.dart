part of 'area_bloc.dart';

@immutable
abstract class AreaState {}

abstract class AreaActionState extends AreaState {}

class AreaInitialState extends AreaState {}

class AreaLoadedState extends AreaState {
  AreaLoadedState(this.allData, this.areaData, this.clickIndexByArea);
  final List<String> areaData;
  final List allData;
  final int clickIndexByArea;
}

class AreaErrorState extends AreaState {}

class NavigateNextPage extends AreaActionState {}
