part of 'api_list_bloc.dart';

abstract class ApiListState extends Equatable {
  const ApiListState();

  @override
  List<Object?> get props => [];
}

class ApiListInitial extends ApiListState {}

class ApiListLoading extends ApiListState {}

class ApiListLoaded extends ApiListState {
  final ApiResponse apiResponse;
  const ApiListLoaded(this.apiResponse);
  @override
  List<Object?> get props => [apiResponse];
}

class ApiListError extends ApiListState {
  final String? message;
  const ApiListError(this.message);
  @override
  List<Object?> get props => [];
}
