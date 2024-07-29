import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/utils/navigation.dart';

import '../../shared/global/app_colors.dart';
import '../../shared/utils/app_assets.dart';
import '../../shared/utils/app_routes.dart';
import '../../shared/utils/app_values.dart';
import '../presentation/controller/home_controller/home_cubit.dart';
import '../presentation/data/task_model.dart';

Widget buildTaskList(List<Task> tasks, String emptyMessage, context) {
  if (tasks.isEmpty) {
    return Center(
        child:
            Text(emptyMessage, style: Theme.of(context).textTheme.titleMedium));
  }

  return RefreshIndicator(
    onRefresh: () async {
      HomeCubit.get(context).fetchTasks();
    },
    child: ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final formattedDate = task.createdAt != null
            ? DateFormat('yyyy/MM/dd').format(task.createdAt)
            : 'No Date'; // Format your date as needed

        Color statusColor;
        switch (task.status) {
          case 'waiting':
            statusColor = AppColors.orangeBold;
            break;
          case 'inProgress':
            statusColor = Colors.blue;
            break;
          case 'finished':
            statusColor = AppColors.primary;
            break;
          default:
            statusColor = AppColors.boldGrey; // Default color
        }

        // Debug print
        print('Task status: ${task.status}, Status color: $statusColor');
        Color priorityColor;
        switch (task.priority) {
          case 'low':
            priorityColor = AppColors.offBlue;
            break;
          case 'medium':
            priorityColor = AppColors.primary;
            break;
          case 'high':
            priorityColor = AppColors.orangeBold;
            break;
          default:
            priorityColor = AppColors.boldGrey; // Default color
        }

        return GestureDetector(
          onTap: () {
            navigateTo(
                context: context,
                screenRoute: Routes.taskDetailScreen,
                arguments: task.id);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                // Image section
                Image(
                  image: NetworkImage(
                    task.image,
                  ),
                  width: mediaQueryWidth(context) * .21,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      ImageAssets.cardIcon,
                      width: mediaQueryWidth(context) * .21,
                    );
                  },
                ),
                // Text and status section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title and status
                          Expanded(
                            child: Text(
                              task.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          SizedBox(width: mediaQueryWidth(context) * .02),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.backgroundRed,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  task.status,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: mediaQueryWidth(context) * .02),
                          Icon(
                            Icons.more_vert_sharp,
                            color: AppColors.dark,
                            size: 30,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              task.desc,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          SizedBox(width: mediaQueryWidth(context) * .02),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageAssets.flag,
                            width: 18,
                            height: 18,
                            color: priorityColor,
                          ),
                          SizedBox(width: mediaQueryWidth(context) * .02),
                          Text(
                            task.priority,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: priorityColor,
                                ),
                          ),
                          const Spacer(),
                          Text(
                            formattedDate,
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
