import 'package:digisina/cores/appIcons/app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPassContainer extends StatelessWidget {
  UserPassContainer(
      {Key? key,
      required this.usernameController,
      required this.passwordController,
      this.onButtonPressed,
      this.isLoading: false})
      : super(key: key);
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final void Function()? onButtonPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: Text(
          "برای ورود اطلاعات زیر را وارد نمایید",
          style: Theme.of(context).textTheme.bodyText1,
        )),
        SizedBox(height: 32),
        TextField(
          enabled: !isLoading,
          controller: usernameController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            labelText: "کد پرسنلی یا شماره همراه",
            prefixIcon: Icon(
              AppIcons.account,
              color: Colors.grey[400],
              size: 21,
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          enabled: !isLoading,
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: "رمز عبور",
            prefixIcon: Icon(
              AppIcons.privacy,
              color: Colors.grey[400],
              size: 30,
            ),
          ),
        ),
        SizedBox(height: 29),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: null,
            child: Row(
              children: [
                Text("ورود با کد فعالسازی"),
                Icon(Icons.keyboard_arrow_left_rounded)
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: !isLoading
              ? ElevatedButton(
                  onPressed: onButtonPressed,
                  child:
                      SizedBox(height: 54, child: Center(child: Text("ادامه"))),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
        ),
      ],
    );
  }
}
