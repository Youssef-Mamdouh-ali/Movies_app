import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movies_app_project/Features/home/presentation/manger/layout_bloc.dart';
import '../../Features/home/data/data_sorces/browse_source.dart';
import '../../Features/home/data/repository_imp/browse_repository_impl.dart';
import '../../Features/home/domain/repository/BrowseRepository.dart';
import '../../Features/home/domain/use_cases/browse_use_case.dart';
import '../network_handler/api_manger/ApiManager.dart';


final sl = GetIt.instance;

void setupServiceLocator() {

  /// Dio
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => ApiManager(sl()));

  /// DataSource
  sl.registerLazySingleton<BrowseRemoteDataSource>(
        () => BrowseRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<BrowseRepository>(
        () => BrowseRepositoryImpl(sl()),
  );

  /// UseCase
  sl.registerLazySingleton(
        () => GetMovies(sl()),
  );

  /// Bloc
  sl.registerFactory(
        () => LayoutBloc(sl()),
  );

}