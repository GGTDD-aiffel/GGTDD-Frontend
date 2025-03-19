import 'package:ggtdd_frontend/data/model/api_recommended_context_tag_model.dart';
import 'package:ggtdd_frontend/data/repositories/recommended_context_tag_repository.dart';

class RecommendedContextTagService {
  final RecommendedContextTagRepository _repository;

  RecommendedContextTagService(
      {required RecommendedContextTagRepository repository})
      : _repository = repository;

  Future<RecommendedContextTagResponse> createRecommendedContextTag(
      RecommendedContextTagCreateRequest request) async {
    return await _repository.createRecommendedContextTag(request);
  }

  Future<RecommendedContextTagResponse?> getRecommendedContextTag(
      String recommendationId) async {
    return await _repository.fetchRecommendedContextTag(recommendationId);
  }

  Future<RecommendedContextTagListResponse> getRecommendedContextTags() async {
    return await _repository.fetchRecommendedContextTags();
  }

  Future<RecommendedContextTagResponse> updateRecommendedContextTag(
      String recommendationId,
      RecommendedContextTagUpdateRequest request) async {
    return await _repository.updateRecommendedContextTag(
        recommendationId, request);
  }

  Future<void> deleteRecommendedContextTag(String recommendationId) async {
    await _repository.deleteRecommendedContextTag(recommendationId);
  }
}
