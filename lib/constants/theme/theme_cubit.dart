import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubits extends Cubit<ThemeState> {
  ThemeCubits() : super(ThemeLight(message: 'Dark Theme'));

  bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    if (_isDark) {
      emit(ThemeDark(message: 'Dark Theme'));
    } else {
      emit(ThemeLight(message: 'Light Theme'));
    }
  }
}
