import 'dart:convert';
import 'dart:typed_data';
import 'package:aurora_image_gen/models/generated_image.model.dart';
import 'package:aurora_image_gen/services/api_client.dart';
import 'package:aurora_image_gen/ui/common/app_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final ApiClient apiClient = ApiClient();
  Future<String> fetchRandomImageUrl() async {
    final response = await apiClient.get(AppConstants.getImageEndpoint);

    if (response.statusCode == 200) {
      final data =
          response.data is String ? json.decode(response.data) : response.data;
      final generatedImage = GeneratedImageModel.fromJson(
        data as Map<String, dynamic>,
      );
      return generatedImage.url;
    } else {
      throw Exception('Failed to load image');
    }
  }

  String optimizeDisplayUrl(String url) {
    if (url.contains('unsplash.com')) {
      final separator = url.contains('?') ? '&' : '?';
      return '$url${separator}w=900&auto=format&fit=crop&q=70';
    }
    return url;
  }

  Future<Uint8List> fetchPaletteBytes(String url) async {
    final response = await apiClient.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'Accept-Version': 'v1',
        },
      ),
    );
    final raw = response.data;
    if (raw is Uint8List) return raw;
    if (raw is List<int>) return Uint8List.fromList(raw);
    throw Exception("Invalid response type for palette bytes");
  }

  String optimizePaletteUrl(String url) {
    if (url.contains('unsplash.com')) {
      final separator = url.contains('?') ? '&' : '?';
      return '$url${separator}w=50&auto=format&fit=crop&q=20';
    }
    return url;
  }
}
