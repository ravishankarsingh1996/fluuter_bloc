import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/test_bloc.dart';
import 'package:flutter_assignment/bloc/test_event.dart';
import 'package:flutter_assignment/bloc/test_state.dart';
import 'package:flutter_assignment/model/topic.dart';
import 'package:flutter_assignment/widget/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateListScreen extends StatefulWidget {
  const CreateListScreen({Key? key}) : super(key: key);

  @override
  State<CreateListScreen> createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TestBloc>().add(FetchTopicsListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestBloc, TestState>(
      bloc: context.read<TestBloc>(),
      listener: (blocContext, state) {
        if (state.showSuccessAlert ?? false) {
          Navigator.of(context).pop();
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: 'You have successfully creates a new Test!',
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state.showTestNameAlert ?? false) {
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Alert',
              message: 'Please enter Test Name!',
              contentType: ContentType.warning,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (blocContext, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Create New Test',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (String data) {
                        context.read<TestBloc>().add(
                            UpdateTopicListEvent(data, state.topicList ?? []));
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.perm_contact_cal_sharp),
                          hintText: 'Test Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Topics',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              if (!(state.isLoading ?? false))
                ...?_buildPanel(state)
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                title: 'Create',
                onPress: () async {
                  context.read<TestBloc>().add(
                      CreateTestEvent(state.testName, state.topicList ?? []));
                },
              ),
            ),
          ),
        );
      },
    );
  }

  List<ExpandablePanel>? _buildPanel(TestState state) {
    return state.topicList?.map<ExpandablePanel>((Topic item) {
      return ExpandablePanel(
        topic: item,
        onSelect: () {
          context
              .read<TestBloc>()
              .add(UpdateTopicListEvent(state.testName, state.topicList ?? []));
        },
      );
    }).toList();
  }
}

class ExpandablePanel extends StatefulWidget {
  final Topic topic;
  final Function() onSelect;

  const ExpandablePanel({Key? key, required this.topic, required this.onSelect})
      : super(key: key);

  @override
  State<ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {
  @override
  Widget build(BuildContext context) {
    var item = widget.topic;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                item.isExpanded = !(item.isExpanded ?? false);
              });
            },
            title: Text(item.topicName.toString()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.white),
            ),
            leading: Checkbox(
                onChanged: (bool? onCheck) {
                  setState(() {
                    item.isSelected = onCheck;
                    item.concepts = item.concepts
                        ?.map((e) {
                          e.isSelected = onCheck;
                          return e;
                        })
                        .cast<Concept>()
                        .toList();
                    widget.onSelect();
                  });
                },
                value: item.isSelected),
            trailing: Icon((item.isExpanded ?? false)
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
          ),
          (item.isExpanded ?? false)
              ? ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: 100, maxHeight: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (builderContext, position) {
                          Concept? data = item.concepts?[position];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Checkbox(
                                    onChanged: (bool? onCheck) {
                                      setState(() {
                                        data?.isSelected = onCheck;
                                        widget.onSelect();
                                      });
                                    },
                                    value: data?.isSelected),
                                Expanded(child: Text(data!.concept.toString())),
                              ],
                            ),
                          );
                        },
                        itemCount: item.concepts?.length),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
