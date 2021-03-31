import 'package:Todo_App/Database/bloc/database_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/all.dart';
import '../../Themes/colors.dart' as appColors;

class TodoListSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
          color: theme.dialogBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [appColors.shadow]),
      child: Consumer(builder: (context, watch, _) {
        return TextField(
          style: theme.textTheme.bodyText1,
          onChanged: (val) {
            BlocProvider.of<DatabaseBlocBloc>(context)
                .add(GetSearchedTask(val));
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20.0),
              hintText: "Search",
              border: InputBorder.none),
        );
      }),
    );
  }
}
