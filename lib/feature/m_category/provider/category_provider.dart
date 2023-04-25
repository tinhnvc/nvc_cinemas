import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/shared/link/categories.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<CategoryModel>>(
  (ref) => CategoriesNotifier(),
);

class CategoriesNotifier extends StateNotifier<List<CategoryModel>> {
  CategoriesNotifier() : super([]) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final categoriesFetch = categoriesFromJson(categories);
    state = categoriesFetch;
  }

  CategoryModel getById(String id) {
    var cat = const CategoryModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.id == id) {
          cat = item;
        }
      }
    }

    return cat;
  }

  CategoryModel getByName(String categoryName) {
    var role = const CategoryModel();
    if (state.isNotEmpty) {
      for (final item in state) {
        if (item.categoryName == categoryName) {
          role = item;
        }
      }
    }

    return role;
  }

  void add(CategoryModel cat) {
    state = [...state, cat];
  }

  void editCategory(CategoryModel category) {
    state = [
      for (final item in state)
        if (item.id == category.id)
          item.copyWith(
            categoryName: category.categoryName,
            categoryNameEn: category.categoryNameEn,
            description: category.description,
            active: category.active,
            createAt: category.createAt,
            updateAt: category.updateAt,
          )
        else
          item,
    ];
  }

  void switchActive(String id, bool value) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(
            active: value,
          )
        else
          item,
    ];
  }
}

final categoryFormProvider = Provider<CategoryFormProvider>(
  (ref) => CategoryFormProvider(),
);

class CategoryFormProvider {
  CategoryFormProvider();

  final addCategoryForm = FormGroup({
    'categoryName': FormControl<String>(),
    'categoryNameEn': FormControl<String>(),
    'description': FormControl<String>(),
    'active': FormControl<String>(),
  });

  final buttonController = RoundedLoadingButtonController();

  Future<void> addCategory(
    WidgetRef ref,
    BuildContext context,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final name = addCategoryForm.control('categoryName').value;
    final nameEn = addCategoryForm.control('categoryNameEn').value;
    final desc = addCategoryForm.control('description').value;
    final category = CategoryModel(
      id: Uuid().v4(),
      categoryName: name,
      categoryNameEn: nameEn,
      description: desc,
      active: true,
      createAt: DateTime.now().millisecondsSinceEpoch,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(categoriesProvider.notifier).add(category);
    FunctionUtil.alertPopUpCreated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> editCategory(
    WidgetRef ref,
    BuildContext context,
    CategoryModel categoryModel,
  ) async {
    buttonController.start();
    await Future.delayed(const Duration(milliseconds: 700));
    final name = addCategoryForm.control('categoryName').value;
    final nameEn = addCategoryForm.control('categoryNameEn').value;
    final desc = addCategoryForm.control('description').value;
    final active = addCategoryForm.control('active').value;
    final category = CategoryModel(
      id: categoryModel.id,
      categoryName: name,
      categoryNameEn: nameEn,
      description: desc,
      active: active == 'true' ? true : false,
      createAt: categoryModel.createAt,
      updateAt: DateTime.now().millisecondsSinceEpoch,
    );
    ref.read(categoriesProvider.notifier).editCategory(category);
    FunctionUtil.alertPopUpUpdated(onPressedConfirm: () {
      Navigator.pop(context);
    });
    buttonController.reset();
  }

  Future<void> changeStatus(WidgetRef ref, BuildContext context) async {}
}
