import 'package:ggtdd_frontend/data/model/api_paraphrase_model.dart';
import 'package:ggtdd_frontend/data/repositories/paraphrase_repository.dart';

class ParaphraseService {
  final ParaphraseRepository _repository;

  ParaphraseService({required ParaphraseRepository repository})
      : _repository = repository;

  Future<ParaphraseResponse> createParaphrase(
      ParaphraseCreateRequest request) async {
    return await _repository.createParaphrase(request);
  }

  Future<ParaphraseResponse?> getParaphrase(String paraphraseId) async {
    return await _repository.fetchParaphrase(paraphraseId);
  }

  Future<ParaphraseListResponse> getParaphrases() async {
    return await _repository.fetchParaphrases();
  }

  Future<ParaphraseResponse> updateParaphrase(
      String paraphraseId, ParaphraseUpdateRequest request) async {
    return await _repository.updateParaphrase(paraphraseId, request);
  }

  Future<void> deleteParaphrase(String paraphraseId) async {
    await _repository.deleteParaphrase(paraphraseId);
  }
}
