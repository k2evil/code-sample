import 'package:digisina/features/auth/data/datasource/auth_datasource.dart';
import 'package:digisina/features/auth/data/repository/auth_repository_impl.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';
import 'package:digisina/features/auth/domain/usecase/authenticate.dart';
import 'package:digisina/features/auth/domain/usecase/check_authentication_status.dart';
import 'package:digisina/features/auth/domain/usecase/delete_authentication_information.dart';
import 'package:digisina/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:digisina/features/blogs/data/datasource/blog_datasource.dart';
import 'package:digisina/features/blogs/data/repository/blog_repository_impl.dart';
import 'package:digisina/features/blogs/domain/repository/blog_repository.dart';
import 'package:digisina/features/blogs/domain/usecase/get_blog_posts.dart';
import 'package:digisina/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:digisina/features/home/data/datasource/home_page_datasource.dart';
import 'package:digisina/features/home/data/repository/home_page_repository_impl.dart';
import 'package:digisina/features/home/domain/repository/home_page_repository.dart';
import 'package:digisina/features/home/domain/usecase/get_home_page_components.dart';
import 'package:digisina/features/home/presentation/bloc/home_bloc.dart';
import 'package:digisina/features/loan/data/datasource/loan_remote_datasource.dart';
import 'package:digisina/features/loan/data/repository/loan_repository_impl.dart';
import 'package:digisina/features/loan/domain/repository/loan_repository.dart';
import 'package:digisina/features/loan/domain/usecase/get_loan_requests.dart';
import 'package:digisina/features/loan/domain/usecase/get_loan_terms.dart';
import 'package:digisina/features/loan/domain/usecase/get_loan_types.dart';
import 'package:digisina/features/loan/domain/usecase/get_loans_list.dart';
import 'package:digisina/features/loan/domain/usecase/send_loan_request.dart';
import 'package:digisina/features/loan/domain/usecase/set_loan_status.dart';
import 'package:digisina/features/loan/presentation/bloc/check_loan_request_bloc.dart';
import 'package:digisina/features/loan/presentation/bloc/personnel_loan_requests_bloc.dart';
import 'package:digisina/features/loan/presentation/bloc/request_loan_bloc.dart';
import 'package:digisina/features/loan/presentation/bloc/loan_terms_bloc.dart';
import 'package:digisina/features/loan/presentation/bloc/loans_list_bloc.dart';
import 'package:digisina/features/ordinance/presentation/bloc/ordinance_bloc.dart';
import 'package:digisina/features/payroll/data/datasource/payroll_remote_datasource.dart';
import 'package:digisina/features/payroll/data/repository/payroll_repository_impl.dart';
import 'package:digisina/features/payroll/domain/repository/payroll_repository.dart';
import 'package:digisina/features/payroll/domain/usecase/get_payroll.dart';
import 'package:digisina/features/payroll/domain/usecase/get_years_and_months.dart';
import 'package:digisina/features/payroll/presentation/bloc/payroll_bloc.dart';
import 'package:digisina/features/polls/data/datasource/poll_datasource.dart';
import 'package:digisina/features/polls/data/repository/polls_repository_impl.dart';
import 'package:digisina/features/polls/domain/repository/polls_repository.dart';
import 'package:digisina/features/polls/domain/usecase/fetch_poll_components.dart';
import 'package:digisina/features/polls/presentation/bloc/polls_list_bloc.dart';
import 'package:digisina/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:digisina/features/profile/data/repository/profile_repository_impl.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';
import 'package:digisina/features/profile/domain/usecase/change_password.dart';
import 'package:digisina/features/profile/domain/usecase/clear_user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/get_user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/persist_user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/update_user_profile.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:digisina/features/support/data/datasources/support_remote_datasource.dart';
import 'package:digisina/features/support/data/respository/support_repository_impl.dart';
import 'package:digisina/features/support/domain/repository/support_repository.dart';
import 'package:digisina/features/support/domain/usecase/send_support_request.dart';
import 'package:digisina/features/support/presentation/bloc/support_bloc.dart';
import 'package:digisina/features/ticket/data/datasource/tickets_datasource.dart';
import 'package:digisina/features/ticket/data/repository/tickets_repository_impl.dart';
import 'package:digisina/features/ticket/domain/repository/tickets_repository.dart';
import 'package:digisina/features/ticket/domain/usecase/get_components.dart';
import 'package:digisina/features/ticket/domain/usecase/get_ticket_messages.dart';
import 'package:digisina/features/ticket/domain/usecase/open_new_ticket.dart';
import 'package:digisina/features/ticket/domain/usecase/send_reply_on_ticket.dart';
import 'package:digisina/features/ticket/presentation/bloc/send_ticket_bloc.dart';
import 'package:digisina/features/ticket/presentation/bloc/ticket_messages_bloc.dart';
import 'package:digisina/features/ticket/presentation/bloc/tickets_bloc.dart';
import 'package:digisina/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'features/ordinance/data/datasource/ordinance_remote_datasource.dart';
import 'features/ordinance/data/repository/Ordinance_repository_impl.dart';
import 'features/ordinance/domain/repository/ordinance_repository.dart';
import 'features/ordinance/domain/usecase/get_ordinance.dart';
import 'features/ordinance/domain/usecase/get_years.dart';
import 'features/profile/data/datasource/profile_remote_datasource.dart';

final sl = GetIt.instance;

void init() {
  //!Cores
  //Secure Storage
  sl.registerSingleton(FlutterSecureStorage());

  //Http Client
  sl.registerLazySingleton<Dio>(() => createDioInstance());

  //!Feature : Authentication
  //DataSources
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthSecureLocalDataSource(
        storage: sl(),
      ));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => IAuthRemoteDataSource(dio: sl()));
  //Repository
  sl.registerLazySingleton<AuthRepository>(() => IAuthRepository(
        localDataSource: sl(),
        remoteDataSource: sl(),
      ));
  //UseCases
  sl.registerLazySingleton<CheckAuthenticationStatus>(
      () => CheckAuthenticationStatus(
            repository: sl(),
          ));
  sl.registerLazySingleton<DeleteAuthenticationInformation>(
      () => DeleteAuthenticationInformation(
            repository: sl(),
          ));
  sl.registerLazySingleton<Authenticate>(() => Authenticate(repository: sl()));
  //Bloc
  sl.registerSingleton<AuthCubit>(AuthCubit(
    checkAuthenticationStatus: sl(),
    deleteAuthenticationInformation: sl(),
    authenticate: sl(),
  ));

  //!Feature : Authentication
  //DataSources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => IProfileRemoteDataSource(dio: sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => IProfileLocalDataSource());
  //Repository
  sl.registerLazySingleton<ProfileRepository>(
      () => IProfileRepository(localDataSource: sl(), remoteDataSource: sl()));
  //UseCases
  sl.registerLazySingleton<PersistUserProfile>(() => PersistUserProfile(
        repository: sl(),
      ));
  sl.registerLazySingleton<ClearUserProfile>(() => ClearUserProfile(
        repository: sl(),
      ));
  sl.registerLazySingleton<ChangePassword>(() => ChangePassword(
        repository: sl(),
      ));
  sl.registerLazySingleton<UpdateUserProfile>(() => UpdateUserProfile(
        repository: sl(),
      ));
  sl.registerLazySingleton<GetUserProfile>(() => GetUserProfile(
        repository: sl(),
      ));
  //Bloc
  sl.registerLazySingleton<UserProfileCubit>(() => UserProfileCubit(
        getUserProfile: sl(),
        persistUserProfile: sl(),
        updateUserProfile: sl(),
        changePassword: sl(),
        clearUserProfile: sl(),
      ));

  //!Feature : Home
  //DataSources
  sl.registerFactory<HomePageRemoteDataSource>(
      () => IHomePageRemoteDataSource(dio: sl()));
  //Repository
  sl.registerFactory<HomePageRepository>(
      () => IHomePageRepository(dataSource: sl()));
  //UseCases
  sl.registerFactory<GetHomePageComponents>(
      () => GetHomePageComponents(repository: sl()));
  //Bloc
  sl.registerFactory<HomeCubit>(() => HomeCubit(getHomePageComponents: sl()));

  //Feature : Blog
  //DataSources
  sl.registerFactory<BlogRemoteDataSource>(
      () => IBlogRemoteDataSource(dio: sl()));
  //Repository
  sl.registerFactory<BlogRepository>(() => IBlogRepository(dataSource: sl()));
  //UseCases
  sl.registerFactory<GetBlog>(() => GetBlog(repository: sl()));
  //Bloc
  sl.registerFactory<BlogCubit>(() => BlogCubit(getBlog: sl()));

  //Feature : Tickets
  sl.registerFactory<TicketsRemoteDataSource>(
      () => ITicketsRemoteDataSource(dio: sl()));
  //Repository
  sl.registerFactory<TicketsRepository>(
      () => ITicketsRepository(dataSource: sl(), profileDataSource: sl()));
  //UseCases
  sl.registerFactory<GetTicketComponents>(() => GetTicketComponents(sl()));
  sl.registerFactory<GetTicketMessages>(() => GetTicketMessages(sl()));
  sl.registerFactory<OpenNewTicket>(() => OpenNewTicket(sl()));
  sl.registerFactory<SendReplyOnTicket>(
      () => SendReplyOnTicket(repository: sl()));
  //Bloc
  sl.registerFactory<TicketComponentsCubit>(
      () => TicketComponentsCubit(getTicketComponents: sl()));
  sl.registerFactory<TicketMessagesCubit>(() => TicketMessagesCubit(
        getTicketMessages: sl(),
        sendReplyOnTicket: sl(),
      ));
  sl.registerFactory<SendTicketCubit>(
      () => SendTicketCubit(openNewTicket: sl()));

  //Features : Payroll
  //DataSources
  sl.registerFactory<PayrollRemoteDataSource>(
      () => IPayrollRemoteDataSource(dio: sl()));
  //Repository
  sl.registerFactory<PayrollRepository>(
      () => IPayrollRepository(datasource: sl()));
  //UseCases
  sl.registerFactory<GetYearsAndMonths>(
      () => GetYearsAndMonths(repository: sl()));
  sl.registerFactory<GetPayroll>(() => GetPayroll(repository: sl()));
  //Bloc
  sl.registerFactory<PayrollCubit>(() => PayrollCubit(
        getYearsAndMonths: sl(),
        getPayroll: sl(),
      ));

//Features : Ordinance
  //DataSources
  sl.registerFactory<OrdinanceRemoteDataSource>(
      () => OrdinanceRemoteMockDataSource());
  //Repository
  sl.registerFactory<OrdinanceRepository>(
      () => IOrdinanceRepository(datasource: sl()));
  //UseCases
  sl.registerFactory<GetYears>(() => GetYears(repository: sl()));
  sl.registerFactory<GetOrdinance>(() => GetOrdinance(repository: sl()));
  //Bloc
  sl.registerFactory<OrdinanceCubit>(() => OrdinanceCubit(
        getYears: sl(),
        getOrdinance: sl(),
      ));

  //Features : Loan
  //DataSources
  sl.registerFactory<LoanRemoteDataSource>(
      () => ILoanRemoteDataSource(dio: sl()));
  //Repository
  sl.registerFactory<LoanRepository>(() => ILoanRepository(dataSource: sl()));
  //UseCases
  sl.registerFactory<GetLoanTerms>(() => GetLoanTerms(repository: sl()));
  sl.registerFactory<GetLoanTypes>(() => GetLoanTypes(repository: sl()));
  sl.registerFactory<GetLoansList>(() => GetLoansList(repository: sl()));
  sl.registerFactory<GetLoanRequests>(() => GetLoanRequests(repository: sl()));
  sl.registerFactory<SendLoanRequest>(() => SendLoanRequest(repository: sl()));
  sl.registerFactory<SetLoanStatus>(() => SetLoanStatus(repository: sl()));
  //Bloc
  sl.registerFactory<LoanTermsCubit>(() => LoanTermsCubit(getLoanTerms: sl()));
  sl.registerFactory<RequestLoanCubit>(
      () => RequestLoanCubit(getLoanTypes: sl(), sendLoanRequest: sl()));
  sl.registerFactory<LoanListCubit>(() => LoanListCubit(getLoansList: sl()));
  sl.registerFactory<PersonnelLoanRequestsCubit>(
      () => PersonnelLoanRequestsCubit(getLoanRequests: sl()));
  sl.registerFactory<CheckLoanRequestCubit>(
      () => CheckLoanRequestCubit(setLoanStatus: sl()));

  //Features : Polls
  //DataSources
  sl.registerFactory<PollsRemoteDataSource>(
      () => IPollsRemoteDataSource(dio: sl()));
  //Repository
  sl.registerFactory<PollsRepository>(() => IPollsRepository(dataSource: sl()));
  //UseCases
  sl.registerFactory<FetchPollComponents>(
      () => FetchPollComponents(repository: sl()));
  //Bloc
  sl.registerFactory<PollsListCubit>(
      () => PollsListCubit(fetchPollComponents: sl()));

  //Features : Support
  //DataSource
  sl.registerFactory<SupportRemoteDataSource>(
      () => SupportMockRemoteDataSource());
  //Repository
  sl.registerFactory<SupportRepository>(
      () => ISupportRepository(dataSource: sl()));
  //UseCase
  sl.registerFactory<SendSupportRequest>(
      () => SendSupportRequest(repository: sl()));
  //Bloc
  sl.registerFactory<SupportCubit>(
      () => SupportCubit(sendSupportRequest: sl()));
}
