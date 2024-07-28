import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo/home/componantes/add_new_task_dial.dart';
import 'package:todo/home/presentation/controller/home_controller/home_cubit.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/utils/app_values.dart';
import 'package:todo/shared/utils/navigation.dart';
import '../../../shared/global/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/app_routes.dart';
import '../../componantes/dialog_log_out.dart';
import '../../componantes/home_shimmer.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is LogOutErrorState) {
          showToast(text: state.message, state: ToastStates.ERROR);
        } else if (state is LogOutSuccessState) {
          showToast(
              text: 'Logged out successfully', state: ToastStates.SUCCESS);
          navigateTo(context: context, screenRoute: Routes.loginScreen);
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return buildShimmerEffect(context);
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
                            navigateTo(
                                context: context,
                                screenRoute: Routes.profileScreen);
                          },
                          child: Image.asset(
                            ImageAssets.profile,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(width: mediaQueryWidth(context) * 0.02),
                        IconButton(
                          onPressed: () async {
                            final shouldLogout =
                                await showLogoutConfirmationDialog(context);
                            if (shouldLogout == true) {
                              context.read<HomeCubit>().logout();
                            }
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
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('My tasks',
                              style: TextStyle(
                                  color: AppColors.boldGrey, fontSize: 22)),
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.01),
                        ButtonsTabBar(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primary,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelSpacing: 10,
                          unselectedDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.backgroundLight.withOpacity(0.5),
                          ),
                          buttonMargin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          height: mediaQueryHeight(context) * 0.05,
                          tabs: const [
                            Tab(
                              child: Text(
                                'All',
                              ),
                            ),
                            Tab(
                              child: Text(
                                'In progress',
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Waiting',
                              ),
                            ),
                            Tab(
                                child: Text(
                              'Finished',
                            ))
                          ],
                          controller: _tabController,
                          unselectedLabelStyle:
                              TextStyle(color: AppColors.boldGrey),
                          labelStyle: TextStyle(color: AppColors.background),
                        ),
                      ],
                    ),
                  )),
              backgroundColor: AppColors.background,
              body: TabBarView(
                controller: _tabController,
                children: [
                  buildTaskList(state.allTasks, 'No tasks available', context),
                  buildTaskList(state.inProgressTasks,
                      'No in-progress tasks available', context),
                  buildTaskList(state.waitingTasks,
                      'No waiting tasks available', context),
                  buildTaskList(state.finishedTasks,
                      'No finished tasks available', context),
                ],
              ),
              floatingActionButton: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildDialQr(
                      context,
                      () {
                        navigateTo(
                            context: context, screenRoute: Routes.qrScreen);
                      },
                    ),
                    SizedBox(height: mediaQueryHeight(context) * 0.02),
                    buildDialAdd(
                      context,
                      () {
                        navigateTo(
                            context: context,
                            screenRoute: Routes.addNewTaskScreen);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is HomeErrorState) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          return Scaffold(body: const Center(child: Text('Unexpected state')));
        }
      },
    );
  }
}
