import 'package:get_it/get_it.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/blocs/calendar/calendar_bloc.dart';
import 'package:schedule/common/config/firebase_setup.dart';
import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/data/local_data_source/personal_hive.dart';
import 'package:schedule/data/local_data_source/schedule_hive.dart';
import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/data/reponsitories/personal_repositories_impl.dart';
import 'package:schedule/data/reponsitories/schedule_repositories_impl.dart';
import 'package:schedule/domain/repositories/personal_repositories.dart';
import 'package:schedule/domain/repositories/schedule_repositories.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';
import 'package:schedule/presentation/bloc/loader_bloc/bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/bloc.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/bloc/register_bloc.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';

class Injector {
  static final getIt = GetIt.instance;
  static void setup() {
    _configuration();
  }

  static void _configuration() {
    _configBloc();
    _configUseCase();
    _configRepository();
    _configDataSource();
    _configNetwork();
    _configCommon();
  }

  static void _configBloc() {
    getIt.registerSingleton<LoaderBloc>(LoaderBloc());
    getIt.registerSingleton<SnackbarBloc>(SnackbarBloc());
    getIt.registerFactory<HomeBloc>(() => HomeBloc(
        personalUS: getIt<PersonalUseCase>(),
        scheduleUS: getIt<ScheduleUseCase>()));
    getIt.registerFactory<RegisterBloc>(() => RegisterBloc(
        snackbarBloc: getIt<SnackbarBloc>(),
        scheduleUseCase: getIt<ScheduleUseCase>(),
        personalUseCase: getIt<PersonalUseCase>()));
    getIt.registerLazySingleton<ScheduleBloc>(() => ScheduleBloc());
    getIt.registerLazySingleton<CalendarBloc>(
      () => CalendarBloc(
          scheduleUS: getIt<ScheduleUseCase>(),
          personalUS: getIt<PersonalUseCase>(),
          scheduleBloc: getIt<ScheduleBloc>()),
    );
    getIt.registerFactory<TodoBloc>(() => TodoBloc(
        snackbarBloc: getIt<SnackbarBloc>(),
        calendarBloc: getIt<CalendarBloc>(),
        personalUS: getIt<PersonalUseCase>()));
  }

  static void _configUseCase() {
    getIt.registerFactory<ScheduleUseCase>(
        () => ScheduleUseCase(getIt<ScheduleRepositories>()));
    getIt.registerFactory<PersonalUseCase>(() =>
        PersonalUseCase(personalRepositories: getIt<PersonalRepositories>()));
  }

  static void _configRepository() {
    getIt.registerLazySingleton<ScheduleRepositories>(() =>
        ScheduleRepositoriesImpl(getIt<DataRemote>(), getIt<ScheduleHive>()));
    getIt.registerLazySingleton<PersonalRepositories>(() =>
        PersonalRepositoriesImpl(getIt<PersonalHive>(), getIt<DataRemote>()));
  }

  static void _configDataSource() {
    getIt.registerLazySingleton<DataRemote>(
        () => DataRemote(firebaseSetup: getIt<FirebaseSetup>()));
    getIt.registerLazySingleton<PersonalHive>(
        () => PersonalHive(hiveConfig: getIt<LocalConfig>()));
    getIt.registerLazySingleton<ScheduleHive>(
        () => ScheduleHive(getIt<LocalConfig>()));
  }

  static void _configNetwork() {}
  static void _configCommon() {
    getIt.registerLazySingleton<FirebaseSetup>(() => FirebaseSetup());
    getIt.registerLazySingleton<LocalConfig>(() => LocalConfig());
  }
}
