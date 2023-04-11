import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final categoryFormProvider = Provider<CategoryFormProvider>(
  (ref) => CategoryFormProvider(),
);

class CategoryFormProvider {
  CategoryFormProvider();

  final addCategoryForm = FormGroup({
    'categoryName': FormControl<String>(),
    'description': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addCategory(WidgetRef ref, BuildContext context) async {}

  Future<void> editCategory(WidgetRef ref, BuildContext context) async {}

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}
