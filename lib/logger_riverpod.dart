import 'package:hooks_riverpod/hooks_riverpod.dart';

// this observer class can be added to Provider Scope
class LoggerRiverpod extends ProviderObserver {
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    // TODO: implement didAddProvider
    super.didAddProvider(provider, value, container);
  }

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    // TODO: implement didUpdateProvider
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
