import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/home/domain/usecase/get_home_page_components.dart';
import 'package:digisina/features/home/presentation/bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required GetHomePageComponents getHomePageComponents})
      : super(HomeUnInitialized()) {
    _getHomePageComponents = getHomePageComponents;
  }

  late final GetHomePageComponents _getHomePageComponents;

  getHomePageComponents() =>
      _getHomePageComponents(NoParams()).then((response) => response.fold(
            (failure) => emit(HomeFailed()),
            (result) => emit(HomeLoaded(components: result)),
          ));
}
