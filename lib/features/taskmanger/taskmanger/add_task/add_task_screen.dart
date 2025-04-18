import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/features/auth/presentation/widgets/comm_auth_button.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/task_screen/task_screen.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/widget/common_textfield.dart';
import 'package:taskmanagementapp/features/taskmanger/taskmanger/bloc/taskmanage_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  @override
  void dispose() {
    controllerTitle.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Create Task")),
      body: BlocListener<TaskmanageBloc, TaskmanageState>(
        listener: (context, state) {
          if (state is TaskmanageSucess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => TaskScreen()),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 300),
                TaskFormField(hintText: 'title', controller: controllerTitle),
                SizedBox(height: 25),
                TaskFormField(
                  hintText: 'Description',
                  controller: controllerDescription,
                ),
                SizedBox(height: 25),
                CommonAuthButton(
                  onPressed: () {
                    context.read<TaskmanageBloc>().add(
                      CreateTaskBloc(
                        title: controllerTitle.text.trim(),
                        description: controllerDescription.text.trim(),
                      ),
                    );
                  },
                  text: "Create Task",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
