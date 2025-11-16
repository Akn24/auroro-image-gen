import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'home_viewmodel.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        final imageSize = MediaQuery.of(context).size.width * 0.6 > 300
            ? 300.0
            : MediaQuery.of(context).size.width * 0.6;

        final isLoading =
            model.isBusy || (model.imageUrl == null && model.err == null);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          color: model.backgroundColor,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: isLoading
                            ? _loading(theme)
                            : model.imageUrl != null
                                ? _image(model)
                                : _loading(theme),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: model.err != null
                        ? Text(
                            model.err!,
                            key: const ValueKey('error'),
                            style: TextStyle(color: theme.colorScheme.error),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox.shrink(key: ValueKey('no-error')),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: model.isBusy ? null : model.fetchImage,
                    child: const Text("Another"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _loading(ThemeData theme) {
    return Container(
      key: const ValueKey('loading'),
      color: theme.colorScheme.surface,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _image(HomeViewModel model) {
    return CachedNetworkImage(
      key: ValueKey(model.imageUrl),
      imageUrl: model.imageUrl!,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 350),
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
      imageBuilder: (context, imageProvider) {
        return Semantics(
          label: 'Random image from Unsplash',
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
