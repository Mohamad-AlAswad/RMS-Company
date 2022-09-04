import 'package:flutter/material.dart';

import '../theme.dart';

darkThemeData() => ThemeData(
      brightness: Brightness.dark,
      primaryColorDark: CustomTheme.c2,
      primaryColorLight: Colors.white,
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: CustomTheme.c2.withBlue(200).withGreen(200),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          shadowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomTheme.c1.withAlpha(200);
              }
              return CustomTheme.c1; // Use the component's default.
            },
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return 10;
              }
              return 30; // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomTheme.c1.withAlpha(200);
              }
              return CustomTheme.c1; // Use the component's default.
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomTheme.c1.withAlpha(100);
              }
              return CustomTheme.c1;
            },
          ),
        ),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: CustomTheme.c1,
        collapsedTextColor: CustomTheme.c1,
        iconColor: CustomTheme.c1,
        textColor: CustomTheme.c1,
      ),
      primaryColor: CustomTheme.c1,
      backgroundColor: CustomTheme.c1,
      tabBarTheme: const TabBarTheme(
        labelPadding: EdgeInsets.all(10),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: CustomTheme.c1,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: CustomTheme.c1,
        ),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: ThemeData.dark().appBarTheme.backgroundColor,
        actionsIconTheme: const IconThemeData(color: CustomTheme.c1),
        iconTheme: const IconThemeData(color: CustomTheme.c1),
      ),
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: Colors.white,
        selectedTileColor: CustomTheme.c1.withAlpha(100),
      ),
    );
