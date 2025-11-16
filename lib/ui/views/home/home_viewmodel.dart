import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:stacked/stacked.dart';
import 'package:aurora_image_gen/app/app.locator.dart';
import 'package:aurora_image_gen/services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService _imageService = locator<ApiService>();

  String? imageUrl;
  String? nextImageUrl;
  Color backgroundColor = Colors.grey.shade200;
  String? err;

  bool _isPrefetching = false;
  bool _isPaletteGenerating = false;
  bool _initialLoaded = false;

  Future<void> init() async {
    if (_initialLoaded) return;
    _initialLoaded = true;
    await fetchImage();
  }

  Future<String?> fetchImage() async {
    if (isBusy) return null;
    setBusy(true);
    err = null;
    notifyListeners();
    try {
      final rawUrl = nextImageUrl ?? await _imageService.fetchRandomImageUrl();
      final displayUrl = _imageService.optimizeDisplayUrl(rawUrl);
      final paletteUrl = _imageService.optimizePaletteUrl(rawUrl);
      _prefetchNextImage();
      imageUrl = displayUrl;
      notifyListeners();
      _generatePalette(paletteUrl);
      return displayUrl;
    } catch (e) {
      err = "Unable to load image";
      notifyListeners();
      return null;
    } finally {
      setBusy(false);
    }
  }

  void _prefetchNextImage() async {
    if (_isPrefetching) return;
    _isPrefetching = true;

    try {
      nextImageUrl = await _imageService.fetchRandomImageUrl();
    } catch (_) {
      nextImageUrl = null;
    } finally {
      _isPrefetching = false;
    }
  }

  Future<void> _generatePalette(String paletteUrl) async {
    if (_isPaletteGenerating) return;
    _isPaletteGenerating = true;
    try {
      final bytes = await _imageService.fetchPaletteBytes(paletteUrl);
      final memoryImage = MemoryImage(bytes);
      final palette = await PaletteGenerator.fromImageProvider(
        memoryImage,
        maximumColorCount: 10,
        size: const Size(50, 50),
      ).timeout(const Duration(seconds: 3));
      final newColor = palette.dominantColor?.color ?? Colors.grey.shade300;
      backgroundColor = newColor;
      notifyListeners();
    } catch (e) {
      debugPrint("Palette generation failed: $e");
      backgroundColor = Colors.grey.shade200;
      notifyListeners();
    } finally {
      _isPaletteGenerating = false;
    }
  }
}
