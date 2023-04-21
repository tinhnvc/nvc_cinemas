import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/feature/m_category/provider/category_provider.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/category_model.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/shared/provider/util_provider.dart';
import 'package:nvc_cinemas/shared/util/function_ulti.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/snack_bar_support.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem({
    required this.category,
    Key? key,
  }) : super(key: key);
  final CategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;
    final isVietnamese = ref.watch(languageProvider) == 'vi';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorName.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.6,
            child: Text(
              isVietnamese
                  ? '${category.categoryName}'
                  : '${category.categoryNameEn}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorName.btnText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: category.categoryNameEn == 'Other'
                    ? () {
                        SnackBarSupport.avoidFunction(
                          context: context,
                          hideAction: true,
                        );
                      }
                    : () {
                        InitUtil.initEditCategory(ref: ref, category: category);
                        Navigator.pushNamed(context, '/edit-category',
                            arguments: category);
                      },
                child: Icon(
                  Icons.edit_note,
                  size: 25,
                  color: ColorName.btnText,
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: category.active ?? false,
                  onChanged: category.categoryNameEn == 'Other'
                      ? (bool value) {
                          SnackBarSupport.avoidFunction(
                            context: context,
                            hideAction: true,
                          );
                        }
                      : (bool value) {
                          if (!value) {
                            FunctionUtil.alertPopUpConfirmWithContent(
                                onPressedConfirm: () {
                                  ref
                                      .read(categoriesProvider.notifier)
                                      .switchActive(category.id!, value);
                                  ref
                                      .read(moviesProvider.notifier)
                                      .moveCategoryToOther(category.id!);
                                },
                                content: 'Danh mục');
                          } else {
                            ref
                                .read(categoriesProvider.notifier)
                                .switchActive(category.id!, value);
                          }
                        },
                  activeColor: category.categoryNameEn == 'Other'
                      ? ColorName.primary.withOpacity(0.2)
                      : ColorName.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
