import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/data.dart';

part 'area_event.dart';
part 'area_state.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  AreaBloc() : super(AreaInitialState()) {
    on<AreaLoadedEvent>((event, emit) async {
      emit(AreaInitialState());
      await Future.delayed(const Duration(seconds: 3));
      Map<String, List<String>>? map = await fromApi();
      emit(AreaLoadedState([], map!.keys.toList(), -1));
    });
    on<AreaClickEvent>((event, emit) async {
      Map<String, List<String>>? map = await fromApi();
      emit(AreaLoadedState(map![event.key]!, map.keys.toList(), event.clickIndex));
    });
    on<NavigateToNextPageEvent>((event, emit) async {
      print('goooooooooooooooo');
      emit(NavigateNextPage());
    });
  }
}
