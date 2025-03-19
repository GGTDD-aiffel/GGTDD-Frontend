import 'package:ggtdd_frontend/data/model/api_occupation_model.dart';
import 'package:ggtdd_frontend/data/repositories/occupation_repository.dart';

class OccupationService {
  final OccupationRepository _repository;

  OccupationService({required OccupationRepository repository})
      : _repository = repository;

  Future<OccupationCreateResponse> createOccupation(
      OccupationCreateRequest request) async {
    return await _repository.createOccupation(request);
  }

  Future<OccupationResponseDto> getOccupation(String occupationId) async {
    return await _repository.fetchOccupation(occupationId);
  }

  Future<OccupationListResponseDto> getOccupations() async {
    return await _repository.fetchOccupations();
  }

  Future<OccupationUpdateResponse> updateOccupation(
      String occupationId, OccupationUpdateRequest request) async {
    return await _repository.updateOccupation(occupationId, request);
  }

  Future<OccupationDeleteResponse> deleteOccupation(String occupationId) async {
    return await _repository.deleteOccupation(occupationId);
  }
}
