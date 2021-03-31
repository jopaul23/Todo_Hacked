part of 'themebloc_bloc.dart';

abstract class ThemeblocEvent extends Equatable {
  const ThemeblocEvent();

  @override
  List<Object> get props => [];
}

class SwitchThemeEvent extends ThemeblocEvent {
  final AppThemes theme;
  SwitchThemeEvent(this.theme);

  @override
  List<Object> get props => [];
}
