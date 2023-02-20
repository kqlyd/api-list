import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:robo_test/model.dart';
import 'package:robo_test/repository/api_list_repository.dart';

part 'api_list_event.dart';
part 'api_list_state.dart';

class ApiListBloc extends Bloc<ApiListEvent, ApiListState> {
  final ApiListRepository userRepository;

  ApiListBloc({required this.userRepository}) : super(ApiListInitial()) {
    on<GetApiList>((event, emit) async {
      try {
        emit(ApiListLoading());
        final apiList = await userRepository.getList();

        emit(ApiListLoaded(apiList));
      } catch (e) {
        emit(const ApiListError("Failed to fetch data. Try again?"));
      }
    });
  }
}
