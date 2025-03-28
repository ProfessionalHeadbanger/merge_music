part of 'access_token_cubit.dart';

@immutable
sealed class AccessTokenState {}

final class AccessTokenNull extends AccessTokenState {}

final class AccessTokenLoaded extends AccessTokenState {
  final String token;
  AccessTokenLoaded({required this.token});
}
