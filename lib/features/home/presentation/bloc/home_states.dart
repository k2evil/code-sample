import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeUnInitialized extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState{
  final HomePageComponents components;

  HomeLoaded({required this.components});

  @override
  List<Object?> get props => [components];
}

class HomeFailed extends HomeState{
  final String? message;

  HomeFailed({this.message});
  @override
  List<Object?> get props => [message];

}
