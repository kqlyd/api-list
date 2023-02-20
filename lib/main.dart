import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_test/bloc/api_list_bloc.dart';
import 'package:robo_test/model.dart';
import 'package:robo_test/repository/api_list_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ApiListScreen(),
    );
  }
}

class ApiListScreen extends StatelessWidget {
  const ApiListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ApiListBloc(userRepository: ApiListRepository()),
          child: SingleChildScrollView(
            child: BlocListener<ApiListBloc, ApiListState>(
              listener: (context, state) {
                if (state is ApiListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message ?? ''),
                    ),
                  );
                }
              },
              child: Center(
                child: Column(
                  children: [
                    BlocBuilder<ApiListBloc, ApiListState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () async {
                            BlocProvider.of<ApiListBloc>(context).add(GetApiList());
                          },
                          child: Text(
                            state is ApiListLoading ? 'Loading ' : 'Fetch apis',
                          ),
                        );
                      },
                    ),
                    BlocBuilder<ApiListBloc, ApiListState>(
                      builder: (context, state) {
                        if (state is ApiListLoading) {
                          return const ApiListLoadingWidget();
                        } else if (state is ApiListLoaded) {
                          return ApiListLoadedWidget(apiResponse: state.apiResponse);
                        } else if (state is ApiListError) {
                          return Text(
                            state.message ?? '',
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ApiListLoadedWidget extends StatelessWidget {
  const ApiListLoadedWidget({
    Key? key,
    this.apiResponse,
  }) : super(key: key);
  final ApiResponse? apiResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Count:${apiResponse?.count?.toString() ?? '0'}',
        ),
        ListView.builder(
          itemCount: apiResponse?.entries?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(apiResponse?.entries?[index].description ?? ''),
              subtitle: Text(apiResponse?.entries?[index].link ?? ''),
            );
          },
        ),
      ],
    );
  }
}

class ApiListLoadingWidget extends StatelessWidget {
  const ApiListLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
