import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/componantes/add_new_task_dial.dart';
import 'package:todo/home/presentation/controller/home_controller/home_cubit.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:todo/shared/utils/navigation.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_routes.dart';
import '../../componantes/widget_card.dart';
import '../controller/home_controller/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<HomeCubit>().fetchTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    context.read<HomeCubit>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeErrorState) {
            // Optionally show a message or handle the error
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadedState) {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Logo',
                    style: TextStyle(
                        color: AppColors.dark,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateTo(context: context, screenRoute: Routes.profileScreen);
                          },
                          child: Image.asset(
                            ImageAssets.profile,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth(context) * 0.02),
                        IconButton(
                          onPressed: () {
                            print('object');
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                  bottom: TabBar(
                    indicatorColor: Colors.red,
                    controller: _tabController,
                    tabs: [
                      _buildTab('All', _tabController.index == 0),
                      _buildTab('Waiting', _tabController.index == 1),
                      _buildTab('In Progress', _tabController.index == 2),
                      _buildTab('Finished', _tabController.index == 3),
                    ],
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                    labelColor: AppColors.background,
                    unselectedLabelColor: AppColors.boldGrey,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                backgroundColor: AppColors.background,
                body: RefreshIndicator(
                  onRefresh: _refresh,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildTaskList(state.allTasks, 'No tasks available'),
                      buildTaskList(
                          state.waitingTasks, 'No waiting tasks available'),
                      buildTaskList(
                          state.inProgressTasks, 'No in-progress tasks available'),
                      buildTaskList(
                          state.finishedTasks, 'No finished tasks available'),
                    ],
                  ),
                ),
                floatingActionButton: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildDialQr (
                        context,
                            () {
                          navigateTo(context: context, screenRoute: Routes.qrScreen);
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) * 0.02),
                      buildDialAdd (
                        context,
                            () {
                          navigateTo(context: context, screenRoute: Routes.addNewTaskScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HomeErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.boldGrey,
        ),
      ),
    );
  }
}
