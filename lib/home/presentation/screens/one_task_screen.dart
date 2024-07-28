import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/global/app_colors.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:todo/shared/utils/app_assets.dart';
import 'package:popup_menu/popup_menu.dart';

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
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              ImageAssets.arrowBack,
              color: AppColors.dark,
              width: 5,
              height: 10,
            ),
          ),
          actions: [
            PopupMenuButtonWidget(taskId: taskId),
          ],
          title: const Text(
            'Task Details',
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TaskLoaded) {
              final task = state.task;
              final DateFormat formatter = DateFormat('d MMMM, yyyy');
              final String formattedDate = formatter.format(task.updatedAt!);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage(task.image),
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



class PopupMenuButtonWidget extends StatelessWidget {
  final String taskId;
  final GlobalKey menuKey = GlobalKey();

  PopupMenuButtonWidget({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Container(

      key: menuKey,
      child: IconButton(
        icon: Icon(Icons.more_vert, color: AppColors.dark),
        onPressed: () {
          PopupMenu menu = PopupMenu(

            config:   MenuConfig(
              backgroundColor: AppColors.primaryback,
              type: MenuType.list,
              itemHeight:   mediaQueryHeight(context) * .04,
              itemWidth:    mediaQueryWidth(context) * .25,

            ),

            context: context,
            items: [

              MenuItem(

                  title: 'Edit', textStyle: TextStyle(color: AppColors.dark)),
              MenuItem(title: 'Delete', textStyle: TextStyle(color: Colors.red)),
            ],
            onClickMenu: (MenuItemProvider item) {
              if (item.menuTitle == 'Edit') {

              } else if (item.menuTitle == 'Delete') {
                // Handle delete action
                _showDeleteConfirmationDialog(context, taskId);
              }
            },
          );
          menu.show(widgetKey: menuKey);
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle delete action here
             // context.read<TaskCubit>().deleteTask(taskId);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
