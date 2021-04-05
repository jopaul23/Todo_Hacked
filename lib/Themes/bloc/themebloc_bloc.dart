import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/Themes/themes/light.dart';

part 'themebloc_event.dart';
part 'themebloc_state.dart';

class ThemeblocBloc extends Bloc<ThemeblocEvent, ThemeblocState> {
  ThemeblocBloc() : super(ThemeblocState(AppThemes.LightGreen));

  @override
  Stream<ThemeblocState> mapEventToState(
    ThemeblocEvent event,
  ) async* {
    if (event is SwitchThemeEvent) {
      yield ThemeblocState(event.theme);
    }
  }
}
