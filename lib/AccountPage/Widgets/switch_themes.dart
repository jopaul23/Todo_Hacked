import 'package:Todo_App/Themes/bloc/themebloc_bloc.dart';
import 'package:Todo_App/Themes/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchThemes extends StatefulWidget {
  @override
  _SwitchThemesState createState() => _SwitchThemesState();
}

class _SwitchThemesState extends State<SwitchThemes> {
  ThemeblocBloc themeBloc;
  @override
  void initState() {
    super.initState();
    themeBloc = ThemeblocBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 20.0,
          );
        },
        itemCount: appThemeMap.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              final key = appThemeMap.keys.toList()[index];

              BlocProvider.of<ThemeblocBloc>(context)
                  .add(SwitchThemeEvent(key));
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appThemeMap.values.toList()[index].primaryColor),
            ),
          );
        });
  }
}
