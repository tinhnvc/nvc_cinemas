import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum FormTextFieldSize { lg, sm }

class FormTextField<T> extends ReactiveTextField<T> {
  FormTextField({
    Key? key,
    String? formControlName,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    bool obscureText = false,
    int? maxLine = 1,
    int? maxLength,
    IconButton? suffixIcon,
    FormTextFieldSize size = FormTextFieldSize.sm,
    TextInputAction textInputAction = TextInputAction.next,
    TextInputType? textInputType,
    VoidCallback? onSubmitted,
    VoidCallback? onTap,
    VoidCallback? onEditingComplete,
    bool isCrudForm = false,
    bool isEditProfileForm = false,
  }) : super(
          key: key,
          maxLength: maxLength,
          formControlName: formControlName,
          keyboardType: textInputType,
          controller: controller,
          style: isEditProfileForm || isCrudForm
              ? const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF363E59),
                  fontWeight: FontWeight.w500,
                )
              : const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF363E59),
                ),
          decoration: InputDecoration(
            errorMaxLines: 10,
            suffixIcon: suffixIcon,
            labelText: labelText,
            isDense: true,
            alignLabelWithHint: true,
            contentPadding: isEditProfileForm
                ? EdgeInsets.only(
                    top: size == FormTextFieldSize.lg ? 10 : 5,
                    left: 10,
                  )
                : isCrudForm
                    ? EdgeInsets.symmetric(
                        vertical: size == FormTextFieldSize.lg ? 20 : 15,
                        horizontal: 10,
                      )
                    : EdgeInsets.symmetric(
                        vertical: size == FormTextFieldSize.lg ? 24 : 20,
                        horizontal: 20,
                      ),
            hintText: hintText,
            hintStyle: const TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 14,
            ),
            labelStyle: const TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 14,
              color: Color(0xFF697392),
            ),
            floatingLabelBehavior:
                isCrudForm ? FloatingLabelBehavior.never : null,
            filled: true,
            fillColor: isEditProfileForm || isCrudForm
                ? Colors.white.withOpacity(0.3)
                : const Color(0xFFEFF1F9),
            enabledBorder: isEditProfileForm
                ? null
                : isCrudForm
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFB4B9C8),
                        ),
                        borderRadius: BorderRadius.circular(
                          size == FormTextFieldSize.lg ? 6 : 4,
                        ),
                      )
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFEFF1F9),
                        ),
                        borderRadius: BorderRadius.circular(
                          size == FormTextFieldSize.lg ? 10 : 6,
                        ),
                      ),
            focusedBorder: isEditProfileForm
                ? null
                : isCrudForm
                    ? OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorName.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(
                          size == FormTextFieldSize.lg ? 6 : 4,
                        ),
                      )
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFEDEFF4),
                        ),
                        borderRadius: BorderRadius.circular(
                          size == FormTextFieldSize.lg ? 10 : 6,
                        ),
                      ),
            border: isEditProfileForm ? InputBorder.none : null,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: isCrudForm
                  ? BorderRadius.circular(
                      size == FormTextFieldSize.lg ? 6 : 4,
                    )
                  : BorderRadius.circular(
                      size == FormTextFieldSize.lg ? 10 : 6,
                    ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: isCrudForm
                  ? BorderRadius.circular(
                      size == FormTextFieldSize.lg ? 6 : 4,
                    )
                  : BorderRadius.circular(
                      size == FormTextFieldSize.lg ? 10 : 6,
                    ),
            ),
            errorStyle: isEditProfileForm || isCrudForm
                ? const TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.clip,
                  )
                : const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.clip,
                  ),
          ),
          maxLines: maxLine,
          obscureText: obscureText,
          textInputAction: textInputAction,
          showErrors: (control) => control.hasErrors,
          onSubmitted: onSubmitted,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
        );
}
