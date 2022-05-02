import 'package:cool_alert/cool_alert.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digisina/cores/appIcons/app_icons.dart';
import 'package:digisina/cores/fixtures/routes.dart';
import 'package:digisina/cores/widget/logo.dart';
import 'package:digisina/features/blogs/domain/repository/blog_repository.dart';
import 'package:digisina/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:digisina/features/blogs/presentation/page/blog_page.dart';
import 'package:digisina/features/home/presentation/bloc/home_bloc.dart';
import 'package:digisina/features/home/presentation/page/home_page.dart';
import 'package:digisina/features/profile/presentation/page/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time/time.dart';
import 'package:digisina/di.dart' as di;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int bottomBarIndex = 1;
  int tabBarIndex = 0;
  bool disableClicks = false;
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          /*if (bottomBarIndex != 1) {
            navigatorKey.currentState?.popUntil((route) => route.isFirst);
            setState(() {
              bottomBarIndex = 1;
            });
            return false;
          } else {
            return true;
          }*/
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            title: Hero(
              tag: "logo",
              child: Logo(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: IconButton(
                  onPressed: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.info,
                      title: "اطلاعیه‌ای وجود ندارد",
                      confirmBtnText: "باشه",
                      onConfirmBtnTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/notif.svg",
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ],
            bottom: bottomBarIndex == 2
                ? TabBar(
                    controller: TabController(length: 2, vsync: this)
                      ..index = tabBarIndex,
                    onTap: (index) {
                      if (tabBarIndex != index) {
                        tabBarIndex = index;
                        _changePage(
                            index == 0 ? Routes.BLOGS : Routes.VIDEO_BLOGS);
                      }
                    },
                    tabs: [
                      Tab(text: "مطالب جدید"),
                      Tab(text: "ویدیوها"),
                    ],
                  )
                : null,
          ),
          body: Stack(
            children: [
              Navigator(
                key: navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: Routes.HOME,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xD9FFFFFF),
                            Color(0x00FFFFFF),
                          ],
                          stops: [
                            0,
                            .5,
                            1
                          ]),
                    ),
                  ))
            ],
          ),
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            index: bottomBarIndex,
            animationDuration: 500.milliseconds,
            backgroundColor: Colors.transparent,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            height: 60,
            items: [
              Icon(
                AppIcons.profile,
                size: 25,
                color: bottomBarIndex == 0
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
              ),
              Icon(
                AppIcons.home,
                size: 25,
                color: bottomBarIndex == 0
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
              ),
              Icon(
                AppIcons.discovery,
                size: 25,
                color: bottomBarIndex == 0
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
              ),
            ],
            onTap: (index) {
              if (bottomBarIndex != index) {
                setState(() {
                  bottomBarIndex = index;
                  tabBarIndex = 0;
                });
                _changePage(
                  index == 0
                      ? Routes.PROFILE
                      : index == 1
                          ? Routes.HOME
                          : index == 2
                              ? Routes.BLOGS
                              : "",
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget? _changePage(String route) {
    navigatorKey.currentState?.pushNamed(route);
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    print("${settings.name}");
    switch (settings.name) {
      case Routes.BLOGS:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<BlogCubit>(
            create: (_) => di.sl(),
            child: BlogsPage(
              type: BlogType.news,
            ),
          ),
        );
      case Routes.HOME:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (_) => di.sl(),
            child: HomePage(),
          ),
        );
      case Routes.VIDEO_BLOGS:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<BlogCubit>(
            create: (_) => di.sl(),
            child: BlogsPage(
              type: BlogType.videos,
            ),
          ),
        );
      case Routes.PROFILE:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Center(child: Text("Unimplemented Page")),
        );
    }
  }
}
