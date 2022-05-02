import 'dart:io';
import 'package:digisina/cores/client/client.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:digisina/features/auth/presentation/page/auth_page.dart';
import 'package:digisina/features/blogs/domain/entity/blog_post.dart';
import 'package:digisina/features/deeplink/presentation/bloc/deeplink_bloc.dart';
import 'package:digisina/features/loan/presentation/bloc/check_loan_request_bloc.dart';
import 'package:digisina/features/loan/presentation/bloc/request_loan_bloc.dart';
import 'package:digisina/features/loan/presentation/pages/check_personnel_loan_request_page.dart';
import 'package:digisina/features/loan/presentation/pages/loan_details_page.dart';
import 'package:digisina/features/loan/presentation/pages/loan_page.dart';
import 'package:digisina/features/loan/presentation/pages/loan_request_page.dart';
import 'package:digisina/features/main/presentation/page/main_page.dart';
import 'package:digisina/features/ordinance/presentation/bloc/ordinance_bloc.dart';
import 'package:digisina/features/payroll/presentation/bloc/payroll_bloc.dart';
import 'package:digisina/features/payroll/presentation/page/payroll_page.dart';
import 'package:digisina/features/polls/presentation/bloc/polls_list_bloc.dart';
import 'package:digisina/features/polls/presentation/page/polls_page.dart';
import 'package:digisina/features/post/presentation/page/post_page.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:digisina/features/profile/presentation/page/edit_profile_page.dart';
import 'package:digisina/features/profile/presentation/page/manage_password_page.dart';
import 'package:digisina/features/support/presentation/bloc/support_bloc.dart';
import 'package:digisina/features/support/presentation/page/support_page.dart';
import 'package:digisina/features/ticket/domain/entity/ticket_components.dart';
import 'package:digisina/features/ticket/presentation/bloc/send_ticket_bloc.dart';
import 'package:digisina/features/ticket/presentation/bloc/ticket_messages_bloc.dart';
import 'package:digisina/features/ticket/presentation/bloc/tickets_bloc.dart';
import 'package:digisina/features/ticket/presentation/page/send_ticket_page.dart';
import 'package:digisina/features/ticket/presentation/page/ticket_messages_page.dart';
import 'package:digisina/features/ticket/presentation/page/tickets_page.dart';
import 'package:digisina/themes/text_themes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'di.dart' as di;
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/loan/domain/entity/loan_entities.dart';
import 'features/ordinance/presentation/page/ordinance_page.dart';

bool appInitiated = false;

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Dio createDioInstance() {
  return Client(
    tokenBuilder: () => di
        .sl<AuthRepository>()
        .getAuthInfo()
        .then<String>((value) => value.getOrElse(() => AuthInfo()).token),
  ).init();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  di.init();
  HttpOverrides.global = new MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  runApp(OKToast(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          title: 'Digisina',
          locale: Locale("FA", "IR"),
          theme: ThemeData(
            fontFamily: "YekanBakh",
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.white),
              shadowColor: Color(0xFFE4F4F9),
            ),
            shadowColor: Color(0xFFE4F4F9),
            tabBarTheme: TabBarTheme(
              labelColor: Color(0xFF202020),
              unselectedLabelColor: Color(0xFF7E9CB5),
              labelStyle: textTheme.subtitle2,
              unselectedLabelStyle: textTheme.subtitle2,
              indicator: UnderlineTabIndicator(
                insets: EdgeInsets.symmetric(horizontal: 36),
                borderSide: BorderSide(color: Color(0xFF55BCD8), width: 4.0),
              ),
            ),
            primaryColor: Color(0xFF55BCD8),
            primaryColorLight: Color(0xFF7E9CB5),
            primaryColorDark: Color(0xFF577590),
            scaffoldBackgroundColor: Color(0xFFF5F5F5),
            cardColor: Colors.white,
            textTheme: textTheme,
            accentTextTheme: textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: "YekanBakh",
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4E4E4E)),
              hintStyle: TextStyle(color: Color(0xFFCECECE)),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCECECE))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E4E4E))),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF55BCD8),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xFF55BCD8),
                textStyle: textTheme.subtitle1,
              ),
            ),
            indicatorColor: Color(0xFF55BCD8),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF577590),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
            ),
          ),
          home: AuthPage(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/main":
                return MaterialPageRoute(builder: (_) => MainPage());
              case "/post":
                var args = settings.arguments as BlogPost;
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PostPage(
                      transitionAnimation: animation,
                      post: args,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 800),
                );
              case "/post/byId":
                var args = settings.arguments as int;
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PostPage.byId(
                      transitionAnimation: animation,
                      id: args,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 800),
                );

              case "/tickets":
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<TicketComponentsCubit>(
                    create: (_) => di.sl(),
                    child: TicketsPage(),
                  ),
                );
              case "/tickets/send":
                var args = settings.arguments as List<TicketRecipient>;
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<SendTicketCubit>(
                    child: SendTicketPage(recipients: args),
                    create: (_) => di.sl(),
                  ),
                );
              case "/tickets/send_to_ceo":
                var args = settings.arguments as List<TicketSubject>;
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<SendTicketCubit>(
                    child: SendTicketPage.toCeo(subjects: args),
                    create: (_) => di.sl(),
                  ),
                );
              case "/tickets/messages":
                var args = settings.arguments as Ticket;
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<TicketMessagesCubit>(
                    child: TicketMessagesPage(ticket: args),
                    create: (_) => di.sl(),
                  ),
                );
              case "/payroll":
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<PayrollCubit>(
                    create: (_) => di.sl(),
                    child: PayrollPage(),
                  ),
                );
              case "/loan":
                return MaterialPageRoute(
                  builder: (context) => LoanPage(),
                );
              case "/ordinance":
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<OrdinanceCubit>(
                    create: (_) => di.sl(),
                    child: OrdinancePage(),
                  ),
                );
              case "/loan/request":
                var args = settings.arguments as TabController;
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<RequestLoanCubit>(
                    create: (_) => di.sl(),
                    child: LoanRequestPage(tabController: args),
                  ),
                );
              case "/loan/check":
                var args = settings.arguments as Loan;
                return MaterialPageRoute(
                  builder: (_) => BlocProvider<CheckLoanRequestCubit>(
                    child: CheckLoanRequestPage(request: args),
                    create: (_) => di.sl(),
                  ),
                );
              case "/loan/details":
                var args = settings.arguments as Loan;
                return MaterialPageRoute(
                  builder: (_) => LoanDetailsPage(loan: args),
                );
              case "/polls":
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<PollsListCubit>(
                    create: (_) => di.sl(),
                    child: PollsPage(),
                  ),
                );
              case "/edit_profile":
                return MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                );
              case "/manage_password":
                return MaterialPageRoute(
                  builder: (context) => ManagePasswordPage(),
                );
              case "/support":
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<SupportCubit>(
                    create: (_) => di.sl(),
                    child: SupportPage(),
                  ),
                );
            }
          },
        ),
      ),
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl()),
        BlocProvider<UserProfileCubit>(create: (_) => di.sl()),
        BlocProvider<DeepLinkCubit>(create: (_) => DeepLinkCubit()),
      ],
    );
  }
}
