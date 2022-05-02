import 'package:digisina/features/loan/presentation/pages/loan_request_page.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:digisina/features/profile/presentation/page/edit_profile_page.dart';
import 'package:flutter/material.dart';

class ManagePasswordPage extends StatefulWidget {
  const ManagePasswordPage({Key? key}) : super(key: key);

  @override
  _ManagePasswordPageState createState() => _ManagePasswordPageState();
}

class _ManagePasswordPageState extends State<ManagePasswordPage> {
  late final UserProfileCubit bloc;

  bool eightChars = false;
  bool specialChar = false;
  bool upperAndLowerCaseChar = false;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(() {
      setState(() {
        eightChars = newPasswordController.text.length >= 8;
        upperAndLowerCaseChar =
            newPasswordController.text.contains(new RegExp(r'[A-Z]'), 0);
        specialChar = newPasswordController.text.isNotEmpty &&
            !newPasswordController.text.contains(RegExp(r'^[\w&.-]+$'), 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 32),
                      FilledTextField(
                        controller: oldPasswordController,
                        labelText: "رمز عبور فعلی",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.end,
                        obscureText: true,
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "فراموشی رمز عبور",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.keyboard_arrow_left_rounded),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "برای ورود رمز عبور جدید شرایط زیر را در نظر بگیرید",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 12),
                          ValidationItem(
                            condition: "استفاده از حداقل ۸ کاراکتر",
                            checked: eightChars,
                          ),
                          SizedBox(height: 4),
                          ValidationItem(
                            condition: "استفاده از حروف کوچک و بزرگ",
                            checked: upperAndLowerCaseChar,
                          ),
                          SizedBox(height: 4),
                          ValidationItem(
                            condition: "استفاده از عدد یا کاراکتر ویژه",
                            checked: specialChar,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      FilledTextField(
                        controller: newPasswordController,
                        labelText: "رمز عبور جدید",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.end,
                        obscureText: true,
                      ),
                      SizedBox(height: 18),
                      FilledTextField(
                        controller: repeatNewPasswordController,
                        labelText: "تکرار رمز عبور جدید",
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.end,
                        obscureText: true,
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            FooterButton(
              child: SizedBox(
                height: 54,
                child: Center(
                  child: Text("ثبت تغییرات"),
                ),
              ),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    repeatNewPasswordController.dispose();
    super.dispose();
  }
}

class ValidationItem extends StatelessWidget {
  final bool checked;
  final String condition;
  final Color checkedColor;
  final Color color;

  const ValidationItem({
    Key? key,
    required this.condition,
    required this.checked,
    this.checkedColor: const Color(0xFF3BD6B8),
    this.color: const Color(0xFFCECECE),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: checked ? checkedColor : color,
          ),
          child: checked
              ? FittedBox(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        SizedBox(width: 8),
        Text(
          condition,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
