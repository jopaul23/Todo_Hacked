part of 'themebloc_bloc.dart';

class ThemeblocState extends Equatable {
  final AppThemes theme;
  const ThemeblocState(this.theme);

  @override
  List<Object> get props => [theme];
}
