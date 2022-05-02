import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:equatable/equatable.dart';

class AuthInfo extends Equatable {
  Status get status {
    if (token.isEmpty) {
      return Status.unauthenticated;
    } else if (token.contains("expired")) {
      return Status.expired;
    } else {
      return Status.authenticated;
    }
  }

  final String token;
  final String refreshToken;
  final UserProfile? profile;

  AuthInfo({
    this.token: "",
    this.refreshToken: "",
    this.profile,
  });

  @override
  List<Object?> get props => [token, refreshToken];
}

enum Status {
  unauthenticated,
  authenticated,
  expired,
}
