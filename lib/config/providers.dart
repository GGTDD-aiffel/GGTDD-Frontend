import 'package:ggtdd_frontend/ui/user/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../data/services/api_service.dart';
import '../data/repositories/user_repository.dart';
import '../config/flavor_config.dart';

List<Provider> getProviders() {
  return [
    Provider<ApiService>(
      create: (_) => ApiService(baseUrl: FlavorConfig.instance.baseUrl),
    ),
    Provider<UserRepository>(
      create: (context) =>
          UserRepository(Provider.of<ApiService>(context, listen: false)),
    ),
    Provider<UserViewModel>(
      create: (context) =>
          UserViewModel(Provider.of<UserRepository>(context, listen: false)),
    ),
  ];
}
