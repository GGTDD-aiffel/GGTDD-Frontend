import 'package:ggtdd_frontend/data/model/api_occupation_model.dart';
import 'package:ggtdd_frontend/data/repositories/occupation_repository.dart';
import 'package:ggtdd_frontend/ui/domain/models/occupation_model.dart';

class OccupationService {
  final OccupationRepository _repository;

  OccupationService({required OccupationRepository repository})
      : _repository = repository;

  Future<Occupation> createOccupation(OccupationCreateRequest request) async {
    return await _repository.createOccupation(request);
  }

  Future<Occupation?> getOccupation(String occupationId) async {
    return await _repository.fetchOccupation(occupationId);
  }

  Future<OccupationListResponse> getOccupations() async {
    return await _repository.fetchOccupations();
  }

  Future<Occupation> updateOccupation(
      String occupationId, OccupationUpdateRequest request) async {
    return await _repository.updateOccupation(occupationId, request);
  }

  Future<void> deleteOccupation(String occupationId) async {
    await _repository.deleteOccupation(occupationId);
  }
}
