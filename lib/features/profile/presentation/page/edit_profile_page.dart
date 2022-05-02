import 'dart:async';

import 'package:digisina/features/loan/presentation/pages/loan_request_page.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_states.dart';
import 'package:digisina/features/ticket/presentation/page/tickets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  late final UserProfileCubit bloc;
  late final StreamSubscription subscription;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UserProfileCubit>(context);
    if (bloc.state is UserProfileLoaded) {
      fillTextFields((bloc.state as UserProfileLoaded).profile);
    } else {
      bloc.getUserProfile();
    }
    subscription = bloc.stream.listen((state) {
      if (state is UserProfileLoaded) {
        fillTextFields((bloc.state as UserProfileLoaded).profile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          title: Text(
            "اطلاعات کاربری",
            style: Theme.of(context).accentTextTheme.headline5,
          ),
        ),
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (_, state) => state is UserProfileLoaded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 20),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: AvatarView(
                                    size: 58,
                                    url: state.profile.avatar,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32),
                              FilledTextField(
                                controller: firstNameController,
                                textInputAction: TextInputAction.next,
                                labelText: "نام",
                              ),
                              SizedBox(height: 16),
                              FilledTextField(
                                controller: lastNameController,
                                textInputAction: TextInputAction.next,
                                labelText: "نام خانوادگی",
                              ),
                              SizedBox(height: 16),
                              FilledTextField(
                                controller: phoneNumberController,
                                textInputAction: TextInputAction.next,
                                labelText: "شماره موبایل",
                              ),
                              SizedBox(height: 16),
                              FilledTextField(
                                controller: emailController,
                                textInputAction: TextInputAction.done,
                                labelText: "ایمیل",
                              ),
                              SizedBox(height: 32)
                            ],
                          ),
                        ),
                      ),
                    ),
                    FooterButton(
                      child: SizedBox(
                        height: 54,
                        child: Center(child: Text("ثبت تغییرات")),
                      ),
                      onTap: () {
                        bloc.updateUserProfile(
                          firstNameController.text,
                          lastNameController.text,
                          phoneNumberController.text,
                          emailController.text,
                        );
                      },
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  fillTextFields(UserProfile profile) {
    firstNameController.text = profile.firstName;
    lastNameController.text = profile.lastName;
    phoneNumberController.text = profile.phoneNumber;
  }

  @override
  void dispose() {
    subscription.cancel();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }
}

class FilledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? labelText;
  final bool obscureText;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final int? minLines;
  final int? maxLines;
  final bool? enabled;

  const FilledTextField({
    Key? key,
    this.controller,
    this.textInputAction,
    this.labelText,
    this.obscureText: false,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.minLines,
    this.maxLines,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.obscureText,
      controller: this.controller,
      textInputAction: this.textInputAction,
      textDirection: this.textDirection,
      textAlign: this.textAlign,
      minLines: minLines,
      maxLines: maxLines ?? minLines,
      enabled: enabled,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        labelText: this.labelText,
        filled: true,
        labelStyle: TextStyle(color: Color(0xFF797979)),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
