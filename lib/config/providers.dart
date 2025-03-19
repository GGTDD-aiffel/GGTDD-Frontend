import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/services/api_service.dart';
import '../config/flavor_config.dart';

List<SingleChildWidget> getProviders() {
  return [
    Provider<ApiService>(
      create: (_) => ApiService(baseUrl: FlavorConfig.instance.baseUrl),
    ),
  ];
}
