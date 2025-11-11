import 'dart:convert';

import 'package:aurora_image_gen/models/generated_image.model.dart';
import 'package:aurora_image_gen/services/api_client.dart';
import 'package:aurora_image_gen/ui/common/app_constants.dart';

class ApiService {
  final ApiClient apiClient = ApiClient();
  Future<String> fetchRandomImageUrl() async {
    final response = await apiClient.get(
      AppConstants.getImageEndpoint,
    );
    if (response.statusCode == 200) {
      final data =
          response.data is String ? json.decode(response.data) : response.data;

      final generatedImage =
          GeneratedImageModel.fromJson(data as Map<String, dynamic>);
      return generatedImage.url;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
