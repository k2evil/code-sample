import 'package:cool_alert/cool_alert.dart';
import 'package:digisina/cores/appIcons/app_icons.dart';
import 'package:digisina/cores/widget/web_view.dart';
import 'package:digisina/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:digisina/features/auth/presentation/page/auth_page.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_states.dart';
import 'package:digisina/features/ticket/presentation/page/tickets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final UserProfileCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) => state is UserProfileLoaded
            ? Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AvatarView(
                          url: state.profile.avatar,
                          size: 48,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${state.profile.firstName} ${state.profile.lastName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          state.profile.position,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 20),
                            ProfileButton(
                              icon: AppIcons.account,
                              title: "اطلاعات کاربری",
                              onTap: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/edit_profile"),
                            ),
                            SizedBox(height: 16),
                            ProfileButton(
                              icon: AppIcons.password,
                              title: "مدیریت رمز عبور",
                              onTap: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/manage_password"),
                            ),
                            SizedBox(height: 16),
                            ProfileButton(
                              icon: AppIcons.contact_to_ceo,
                              title: "پیام ها",
                              onTap: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/tickets"),
                            ),
                            SizedBox(height: 16),
                            ProfileButton(
                              icon: AppIcons.support,
                              title: "پشتیبانی",
                              onTap: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/support"),
                            ),
                            SizedBox(height: 16),
                            ProfileButton(
                              icon: AppIcons.discovery,
                              title: "ثبت اعضا خانواده",
                              isEnabled:
                                  state.profile.family?.isNotEmpty ?? false,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => WebViewWidget(
                                            title: "ثبت اعضا خانواده",
                                            link: state.profile.family!)));
                              },
                            ),
                            SizedBox(height: 16),
                            ProfileButton(
                              icon: AppIcons.logout,
                              title: "خروج از ناحیه کاربری",
                              onTap: showExitDialog,
                            ),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  void showExitDialog() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        widget: Text("آیا برای خروج از حساب کاربری اطمینان دارید؟"),
        title: "",
        showCancelBtn: true,
        confirmBtnText: "خروج",
        onConfirmBtnTap: () {
          BlocProvider.of<AuthCubit>(context).logOut();
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => AuthPage(),
              ),
              (route) => false);
        },
        cancelBtnText: "انصراف",
        onCancelBtnTap: () {
          Navigator.of(context, rootNavigator: true).pop();
        });
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {Key? key,
      required this.icon,
      required this.title,
      this.onTap,
      this.isEnabled = true})
      : super(key: key);

  final IconData icon;
  final String title;
  final bool isEnabled;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isEnabled || onTap == null) return;
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.all(19),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isEnabled ? Theme.of(context).primaryColor : Colors.grey,
              size: 25,
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isEnabled
                    ? Theme.of(context).primaryColorDark
                    : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.keyboard_arrow_left_rounded,
              color:
                  isEnabled ? Theme.of(context).primaryColorDark : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
