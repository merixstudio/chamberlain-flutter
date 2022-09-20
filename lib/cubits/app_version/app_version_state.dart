part of 'app_version_cubit.dart';

@freezed
class AppVersionState with _$AppVersionState {
  const AppVersionState._();
  const factory AppVersionState.initial() = _Initial;
  const factory AppVersionState.loaded(String version) = _Loaded;

  String? get version => maybeMap(
        loaded: (state) => state.version,
        orElse: () => null,
      );
}
