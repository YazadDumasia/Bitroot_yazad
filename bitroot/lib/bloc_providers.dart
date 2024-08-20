import 'package:bitroot/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
  BlocProvider<ReviewScheduleSequentialModeBloc>(
      create: (context) => ReviewScheduleSequentialModeBloc()),
  BlocProvider<ReviewScheduleSimultaneousModeBloc>(
      create: (context) => ReviewScheduleSimultaneousModeBloc()),
];
