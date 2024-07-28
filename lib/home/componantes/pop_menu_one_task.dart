import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:todo/home/presentation/controller/home_controller/home_cubit.dart';
import 'package:todo/shared/components/toast_component.dart';
import '../../shared/global/app_colors.dart';
import '../../shared/utils/app_routes.dart';
import '../../shared/utils/navigation.dart';
import '../presentation/controller/one_task_controller/one_task_cubit.dart';
import '../presentation/controller/one_task_controller/one_task_states.dart';
import '../presentation/data/task_model.dart';

class PopupMenuButtonWidget extends StatelessWidget {
  final Task task;
  final GlobalKey menuKey = GlobalKey();

  PopupMenuButtonWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is DeleteLoaded) {
          showToast(text: 'تم الحذف بنجاح', state: ToastStates.SUCCESS);
        } else if (state is DeleteError) {
          showToast(text: state.message, state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Container(
          key: menuKey,
          child: IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.dark),
            onPressed: () {
              PopupMenu menu = PopupMenu(
                config: MenuConfig(
                  backgroundColor: AppColors.primaryback,
                  type: MenuType.list,
                  itemHeight: MediaQuery.of(context).size.height * .04,
                  itemWidth: MediaQuery.of(context).size.width * .25,
                ),
                context: context,
                items: [
                  MenuItem(
                    title: 'Edit',
                    textStyle: TextStyle(color: AppColors.dark),
                  ),
                  MenuItem(
                    title: 'Delete',
                    textStyle: TextStyle(color: Colors.red),
                  ),
                ],
                onClickMenu: (MenuItemProvider item) {
                  if (item.menuTitle == 'Edit') {
                    navigateTo(
                      context: context,
                      screenRoute: Routes.editTaskScreen,
                      arguments: {
                        'taskId': task.id,
                        'image': task.image,
                        'title': task.title,
                        'desc': task.desc,
                        'priority': task.priority,
                        'dueDate': task.updatedAt.toString(),
                        'status': task.status,
                      },
                    );
                  } else if (item.menuTitle == 'Delete') {
                    _showDeleteConfirmationDialog(context, task.id);
                  }
                },
              );
              menu.show(widgetKey: menuKey);
            },
          ),
        );
      },
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
              context.read<TaskCubit>().deleteTask(taskId, context);
              context.read<HomeCubit>().fetchTasks();
              navigateTo(context: context, screenRoute: Routes.homeScreen ) ;
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
