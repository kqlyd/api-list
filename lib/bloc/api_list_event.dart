part of 'api_list_bloc.dart';

abstract class ApiListEvent extends Equatable {
  const ApiListEvent();

  @override
  List<Object> get props => [];
}

class GetApiList extends ApiListEvent {}
