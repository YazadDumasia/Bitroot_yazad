part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeUpdated extends ThemeState {
  final ThemeMode themeMode;

  ThemeUpdated({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
