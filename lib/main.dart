import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/test_bloc.dart';
import 'package:flutter_assignment/repository/topic_repository.dart';
import 'package:flutter_assignment/ui/test_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'storage/local_storage_use_case.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localStorage = LocalStorageUseCase();
    var topicRepository = TopicRepository();
    return MultiProvider(
      providers: [
        Provider<LocalStorageUseCase>.value(value: localStorage),
        Provider<TopicRepository>.value(value: topicRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TestBloc>.value(
              value: TestBloc(localStorage, topicRepository))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const TestListScreen(),
        ),
      ),
    );
  }
}
