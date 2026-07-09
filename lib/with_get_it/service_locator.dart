import 'package:get_it/get_it.dart';
import '../services/api_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Register ApiService as a singleton dependency
  locator.registerLazySingleton<ApiService>(() => ApiService());
}
