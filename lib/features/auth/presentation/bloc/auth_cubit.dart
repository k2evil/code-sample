import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/auth/domain/usecase/authenticate.dart'
    as auth;
import 'package:digisina/features/auth/domain/usecase/check_authentication_status.dart';
import 'package:digisina/features/auth/domain/usecase/delete_authentication_information.dart';
import 'package:digisina/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required CheckAuthenticationStatus checkAuthenticationStatus,
    required DeleteAuthenticationInformation deleteAuthenticationInformation,
    required auth.Authenticate authenticate,
  }) : super(AuthUninitialized()) {
    this._checkAuthenticationStatus = checkAuthenticationStatus;
    this._deleteAuthenticationInformation = deleteAuthenticationInformation;
    this._authenticate = authenticate;
  }

  late final CheckAuthenticationStatus _checkAuthenticationStatus;
  late final DeleteAuthenticationInformation _deleteAuthenticationInformation;
  late final auth.Authenticate _authenticate;

  checkAuthInfo() async {
    emit(AuthLoading());
    var result = await _checkAuthenticationStatus(NoParams());
    result.fold(
      (failure) => emit(AuthError(code: 0)),
      (response) => emit(AuthInfoFetched(authInfo: response)),
    );
  }

  logOut() async {
    emit(AuthLoading());
    var result = await _deleteAuthenticationInformation(NoParams());
    result.fold(
      (failure) => emit(state),
      (success) => emit(LoggedOut()),
    );
  }

  authenticate({required String username, required String password}) async {
    emit(AuthLoading());
    var response = await _authenticate(
        auth.Params(username: username, password: password));
    response.fold(
      (failure) => emit(AuthError(message: "", code: 0)),
      (result) => emit(AuthInfoFetched(authInfo: result)),
    );
  }
}
