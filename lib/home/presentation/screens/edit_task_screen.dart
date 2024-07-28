import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:todo/shared/utils/navigation.dart';

import '../../../auth/presentation/screens/register_screen.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_routes.dart';
import '../../componantes/custom_drop_dow_widget.dart';
import '../controller/edit_task_controller/edit_task_cubit.dart';

class EditTaskScreen extends StatelessWidget {
  final TextEditingController imageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final String taskId;

  EditTaskScreen({
    super.key,
    required this.taskId,
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
    required String status,
  }) {
    imageController.text = image;
    titleController.text = title;
    descController.text = desc;
    priorityController.text = priority;
    dueDateController.text = dueDate;
    statusController.text = status;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTaskCubit(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leadingWidth: 30,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                ImageAssets.arrowBack,
                color: AppColors.dark,
              ),
            ),
          ),
          title: const Text('Edit Task',
              style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: DottedBorder(
                    color: AppColors.primary,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      child: SizedBox(
                        width: double.infinity,
                        height: mediaQueryHeight(context) * 0.1,
                        child: const Center(
                          child: Text(
                            'Add Img',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                const Text('Task Title',
                    style: TextStyle(color: AppColors.boldGrey)),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                TextField(
                  controller: titleController,
                  decoration: inputDecoration('Enter Title here..'),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                const Text('Task Description',
                    style: TextStyle(color: AppColors.boldGrey)),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                TextField(
                  controller: descController,
                  decoration: inputDecoration('Enter Description here..',
                      alignLabelWithHint: true),
                  maxLines: 4,
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                const Text('Task Priority',
                    style: TextStyle(color: AppColors.boldGrey)),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                CustomDropdown(
                  priorityController: priorityController,
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                const Text('Due Date',
                    style: TextStyle(color: AppColors.boldGrey)),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                TextField(
                  controller: dueDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter due date...',
                    labelStyle: TextStyle(color: AppColors.boldGrey),
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: AppColors.boldGrey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: AppColors.boldGrey,
                      ),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Theme.of(context).primaryColor,
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                            scaffoldBackgroundColor:
                                Theme.of(context).primaryColor,
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      dueDateController.text = formattedDate;
                    }
                  },
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                BlocConsumer<EditTaskCubit, EditTaskState>(
                  listener: (context, state) {
                    if (state is EditTaskSuccess) {
                      showToast(
                          text: 'Task updated successfully',
                          state: ToastStates.SUCCESS);
                      navigateTo(context: context, screenRoute: Routes.taskDetailScreen, arguments: taskId);
                    } else if (state is EditTaskFailure) {
                      showToast(text: state.error, state: ToastStates.ERROR);
                    }
                  },
                  builder: (context, state) {
                    if (state is EditTaskLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primary,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EditTaskCubit>(context).updateTask(
                            taskId: taskId,
                            image: imageController.text,
                            title: titleController.text,
                            desc: descController.text,
                            priority: priorityController.text,
                            status: statusController.text,
                          );
                          print(dueDateController.text);
                          print(priorityController.text);
                          print(descController.text);
                          print(titleController.text);
                          print(imageController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Update Task',
                          style: TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
