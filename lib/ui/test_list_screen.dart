import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/test_bloc.dart';
import 'package:flutter_assignment/bloc/test_state.dart';
import 'package:flutter_assignment/widget/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_test_screen.dart';

class TestListScreen extends StatefulWidget {
  const TestListScreen({Key? key}) : super(key: key);

  @override
  State<TestListScreen> createState() => _TestListScreenState();
}

class _TestListScreenState extends State<TestListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Center(
                      child: Text(
                    'Mock Test App',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
                  const Icon(
                    Icons.my_library_books_outlined,
                    size: 200,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'Create New Test',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                            value: context.read<TestBloc>())
                                      ],
                                      child: const CreateListScreen())));
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 3,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocConsumer<TestBloc, TestState>(
                bloc: context.read<TestBloc>(),
                listener: (context, state) {},
                builder: (context, state) {
                  return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.testList?.length,
                      itemBuilder: (_, index) {
                        var test = state.testList?[index];
                        return Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Colors.blue.withOpacity(0.2)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${test?.testName}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w800),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: 'Created on: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54)),
                                        TextSpan(text: ' ${test?.createdAt}'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
