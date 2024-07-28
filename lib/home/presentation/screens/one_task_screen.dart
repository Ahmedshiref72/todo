import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_values.dart';
import '../../componantes/contanier_widget.dart';
import '../../componantes/qr_code_widget.dart';
import '../controller/one_task_controller/one_task_cubit.dart';
import '../controller/one_task_controller/one_task_states.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  TaskDetailsScreen({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..getTaskById(taskId),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leadingWidth: 35,
          leading:  GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(ImageAssets.arrowBack,color:   AppColors.dark, width: 5,height: 10,)),
          title: const Text('Task Details',
              style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              // Define the date format
              final DateTime updatedAt;

              final DateFormat formatter = DateFormat('d MMMM, yyyy');
              final String formattedDate =
                  formatter.format(state.task.updatedAt!);
              final task = state.task;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage(
                        task.image,
                      ),
                      width: mediaQueryWidth(context),
                      height: mediaQueryHeight(context) * .2,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          ImageAssets.imageDetails,
                          width: mediaQueryWidth(context),
                          height: mediaQueryHeight(context) * .2,
                        );
                      },
                    ),
                    Text(task.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: mediaQueryHeight(context) * .01),
                    Text(task.desc,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.boldGrey)),
                    SizedBox(height: mediaQueryHeight(context) * .01),
                    taskDetailsWidget(context, formattedDate),
                    SizedBox(height: mediaQueryHeight(context) * .01),
                    taskDetailsOneTextWidget(context, task.priority),
                    SizedBox(height: mediaQueryHeight(context) * .01),
                    taskDetailsOneFlagWidget(context, task.status),
                    SizedBox(height: mediaQueryHeight(context) * .04),
                    QrCodeWidget(taskId: task.id),
                    // Add more task details here
                  ],
                ),
              );
            } else if (state is TaskError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
