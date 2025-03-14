import 'package:ggtdd_frontend/ui/user/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/services/api_service.dart';
import '../data/repositories/user_repository.dart';
import '../config/flavor_config.dart';

List<SingleChildWidget> getProviders() {
  return [
    Provider<ApiService>(
      create: (_) => ApiService(baseUrl: FlavorConfig.instance.baseUrl),
    ),
    Provider<UserRepository>(
      create: (context) =>
          UserRepository(Provider.of<ApiService>(context, listen: false)),
    ),
    ChangeNotifierProvider<UserViewModel>(
      create: (context) =>
          UserViewModel(Provider.of<UserRepository>(context, listen: false)),
    ),
  ];
}
