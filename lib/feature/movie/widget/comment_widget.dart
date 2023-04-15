import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nvc_cinemas/feature/m_movie/provider/m_movie_provider.dart';
import 'package:nvc_cinemas/feature/movie/model/movie_model.dart';
import 'package:nvc_cinemas/feature/movie/provider/movie_rating_provider.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/util/init_util.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CommentModalSheet extends ConsumerWidget {
  const CommentModalSheet({
    required this.movie,
    Key? key,
  }) : super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(
                  left: 25,
                  // top: 10,
                  // bottom: 10,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.rateMovie,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF363E59),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Divider(
                  height: 3,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: ReactiveForm(
                          formGroup:
                              ref.read(movieRatingFormProvider).addCommentForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: 5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  ref
                                      .read(movieRatingFormProvider)
                                      .addCommentForm
                                      .control('star')
                                      .value = rating.toString();
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                context.l10n.comment,
                                style: const TextStyle(
                                  color: Color(0xFF363E59),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: FormTextField(
                                  isCrudForm: true,
                                  formControlName: 'comment',
                                  maxLine: 5,
                                  textInputAction: TextInputAction.newline,
                                  labelText: context.l10n.comment,
                                  hintText: context.l10n.inputComment,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 25,
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                context.l10n.back,
                                style: const TextStyle(
                                  color: Color(0xFF363E59),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RoundedLoadingButton(
                              color: ColorName.primary,
                              borderRadius: 5,
                              height: 40,
                              width: 110,
                              animateOnTap: false,
                              controller: ref
                                  .watch(movieRatingFormProvider)
                                  .buttonController,
                              onPressed: () {
                                ref
                                    .read(movieRatingFormProvider)
                                    .addComment(ref, context);
                              },
                              child: Text(
                                context.l10n.comment,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
