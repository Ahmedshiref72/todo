import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/network/dio_helper.dart';
import '../../data/task_model.dart';
import 'add_new_task_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class TodoCubit extends Cubit<TodoState> {
  final TextEditingController imageController = TextEditingController();

  TodoCubit() : super(TodoInitial());

  void createTodo({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  }) async {
    emit(TodoLoading());
    try {
      final response = await DioHelper.postData(
        url: '/todos',
        data: {
          'image': image,
          'title': title,
          'desc': desc,
          'priority': priority,
          'dueDate': dueDate,
        },
      );
      final todo = Task.fromJson(response.data);
      emit(TodoSuccess(todo));
    } catch (error) {
      emit(TodoFailure(error.toString()));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      await _uploadImage(imageFile);
    } else {
      emit(ImageUploadFailure('No image selected'));
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    emit(ImageUploadLoading());
    try {
      final response = await DioHelper.uploadFile(
        url: '/upload/image',
        file: imageFile,
      );
      final imageUrl = response.data['imageUrl'];
      imageController.text = imageUrl;
      emit(ImageUploadSuccess(imageUrl));
    } catch (error) {
      emit(ImageUploadFailure(error.toString()));
    }
  }
}
