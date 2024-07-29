import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/components/custom_dicoration.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_strings.dart';
import '../../componantes/custom_drop_dow_widget.dart';
import '../controller/add_new_task_controller/add_new_task_states.dart';
import '../controller/add_new_task_controller/add_new_tsk_cubit.dart';
import '../controller/home_controller/home_cubit.dart';

class AddNewTaskScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Added form key
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
          leadingWidth: 30,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
            ),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  ImageAssets.arrowBack,
                  color: AppColors.dark,
                )),
          ),
          title: Text(AppStrings.addNewTask,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.dark,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => TodoCubit(),
            child: BlocConsumer<TodoCubit, TodoState>(
              listener: (context, state) {
                if (state is TodoSuccess) {
                  showToast(
                      text: AppStrings.taskCreated, state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                  BlocProvider.of<HomeCubit>(context).fetchTasks();
                } else if (state is TodoFailure) {
                  showToast(text: state.error, state: ToastStates.ERROR);
                } else if (state is ImageUploadFailure) {
                  showToast(text: state.error, state: ToastStates.ERROR);
                } else if (state is ImageUploadSuccess) {
                  // Handle image upload success if needed
                }
              },
              builder: (context, state) {
                var cubit = BlocProvider.of<TodoCubit>(context);

                return Form(
                  key: _formKey, // Wrap widgets in a Form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context, cubit),
                        child: DottedBorder(
                          color: AppColors.primary,
                          strokeWidth: 2,
                          dashPattern: const [6, 3],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            child: SizedBox(
                              width: double.infinity,
                              height: mediaQueryHeight(context) * 0.1,
                              child: cubit.imageController.text.isNotEmpty
                                  ? Image.network(cubit.imageController.text)
                                  : const Center(
                                child: Text(
                                  AppStrings.addImg,
                                  style:
                                  TextStyle(color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      const Text(AppStrings.taskTitle,
                          style: TextStyle(color: AppColors.boldGrey)),
                      SizedBox(height: mediaQueryHeight(context) * 0.01),
                      TextFormField(
                        controller: titleController,
                        decoration: inputDecoration(AppStrings.enterTitle),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      const Text(AppStrings.taskDesc,
                          style: TextStyle(color: AppColors.boldGrey)),
                      SizedBox(height: mediaQueryHeight(context) * 0.01),
                      TextFormField(
                        controller: descController,
                        decoration: inputDecoration(AppStrings.enterDesc,
                            alignLabelWithHint: true),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      const Text(AppStrings.taskPriority,
                          style: TextStyle(color: AppColors.boldGrey)),
                      SizedBox(height: mediaQueryHeight(context) * 0.01),
                      CustomDropdown(
                        priorityController: priorityController,
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      const Text(AppStrings.dueDate,
                          style: TextStyle(color: AppColors.boldGrey)),
                      SizedBox(height: mediaQueryHeight(context) * 0.01),
                      TextFormField(
                        controller: dueDateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: AppStrings.enterDueDate,
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
                                  buttonTheme: ButtonThemeData(
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
                      state is TodoLoading
                          ? const CircularProgressIndicator(
                        color: AppColors.primary,
                      )
                          : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primary,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              cubit.createTodo(
                                image: cubit.imageController.text,
                                title: titleController.text,
                                desc: descController.text,
                                priority: priorityController.text,
                                dueDate: dueDateController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            AppStrings.addTask,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context, TodoCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  cubit.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  cubit.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
