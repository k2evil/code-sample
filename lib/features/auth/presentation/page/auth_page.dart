import 'dart:async';

import 'package:digisina/cores/utils/uiUtils.dart';
import 'package:digisina/cores/widget/logo.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:digisina/features/auth/presentation/bloc/auth_states.dart';
import 'package:digisina/features/auth/presentation/widget/userpass.dart';
import 'package:digisina/features/deeplink/presentation/bloc/deeplink_bloc.dart';
import 'package:digisina/features/main/presentation/page/main_page.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:digisina/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time/time.dart';
import 'package:uni_links/uni_links.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  _State pageState = _State.splash;
  late double screenHeight;
  late double screenWidth;
  late final AuthCubit bloc;
  late final UserProfileCubit profileBloc;
  late final DeepLinkCubit deepLinkCubit;
  static final double APPBAR_COLLAPSED_HEIGHT_FACTOR = 0.2564;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isInputsValid = false;
  bool isLoading = false;
  late final StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appInitiated = true;
    bloc = BlocProvider.of<AuthCubit>(context);
    profileBloc = BlocProvider.of<UserProfileCubit>(context);
    deepLinkCubit = BlocProvider.of<DeepLinkCubit>(context);
    _checkForAuthenticationStatus();
    usernameController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  Future<String?> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      return initialLink;
    } on PlatformException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: 1000.milliseconds,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.color,
                        borderRadius: pageState == _State.splash
                            ? BorderRadius.zero
                            : BorderRadius.only(
                                bottomRight: Radius.circular(24),
                                bottomLeft: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            spreadRadius: 4,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      height: pageState == _State.splash
                          ? constraints.constrainHeight()
                          : screenHeight * APPBAR_COLLAPSED_HEIGHT_FACTOR,
                      child: Center(
                        child: Hero(
                          tag: "logo",
                          child: Logo(width: screenWidth * 0.48),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: pageState == _State.splash
                            ? 0
                            : constraints.constrainHeight() -
                                (screenHeight * APPBAR_COLLAPSED_HEIGHT_FACTOR),
                      ),
                      child: IntrinsicHeight(
                        child: pageState == _State.splash
                            ? Container()
                            : pageState == _State.userPass
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 80,
                                        right: 16,
                                        left: 16,
                                        bottom: 40),
                                    child: UserPassContainer(
                                      isLoading: isLoading,
                                      usernameController: usernameController,
                                      passwordController: passwordController,
                                      onButtonPressed:
                                          isInputsValid ? _authenticate : null,
                                    ),
                                  )
                                : Container(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    subscription.cancel();
    super.dispose();
  }

  _checkForAuthenticationStatus() async {
    await Future.delayed(2.seconds);
    var deepLink = deepLinkCubit.state;
    bloc.checkAuthInfo();
    subscription = bloc.stream.listen((state) {
      if (state is AuthInfoFetched) {
        switch (state.authInfo.status) {
          case Status.expired:
          case Status.unauthenticated:
            setState(() {
              pageState = _State.userPass;
            });
            break;
          case Status.authenticated:
            if (state.authInfo.profile != null) {
              profileBloc.setUserProfile(state.authInfo.profile!);
            } else {
              profileBloc.getUserProfile();
            }
            if (deepLink == null ||
                !deepLink.queryParameters.containsKey("post"))
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/main", (route) => false);
            else
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/post/byId", (route) => false,
                  arguments: int.tryParse(deepLink.queryParameters["post"]!));
            break;
        }
      }
      if (state is AuthError) {
        showCustomToast("نام کاربری یا رمز عبور اشتباه است");
      }
      if (state is AuthLoading) {
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  _validateInputs() {
    if (pageState == _State.userPass) {
      var isUsernameValid = usernameController.text.isNotEmpty &&
          usernameController.text.length >= 5;
      var isPasswordValid = passwordController.text.isNotEmpty;
      if (isUsernameValid && isPasswordValid && !isInputsValid) {
        setState(() {
          isInputsValid = true;
        });
      } else if ((!isUsernameValid || !isPasswordValid) && isInputsValid) {
        setState(() {
          isInputsValid = false;
        });
      }
    }
  }

  _authenticate() {
    bloc.authenticate(
      username: usernameController.text,
      password: passwordController.text,
    );
  }
}

enum _State {
  splash,
  phoneNumber,
  smsToken,
  userPass,
}
