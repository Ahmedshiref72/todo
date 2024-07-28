
import '../../data/task_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeLoadedState extends HomeStates {
  final List<Task> waitingTasks;
  final List<Task> inProgressTasks;
  final List<Task> finishedTasks;
  final List<Task> allTasks;

  HomeLoadedState({
    required this.waitingTasks,
    required this.inProgressTasks,
    required this.finishedTasks,
    required this.allTasks,
  });
}

class HomeErrorState extends HomeStates {
  final String message;

  HomeErrorState(this.message);
}
