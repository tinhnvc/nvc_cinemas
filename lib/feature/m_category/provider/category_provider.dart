import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/shared/link/categories.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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

  void add(CategoryModel cat) {
    state = [...state, cat];
  }
}

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
