import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light());

  // Method to toggle between light and dark themes
  void toggleTheme() {
    if (state.brightness == Brightness.dark) {
      emit(ThemeData.light());
    } else {
      emit(ThemeData.dark());
    }
  }
}
