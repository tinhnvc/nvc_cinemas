import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nvc_cinemas/shared/provider/user_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditAccountInformation extends ConsumerWidget {
  const EditAccountInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }

  // ignore: long-method
  Container buildRowEdit({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    final isEditing = ref.watch(editingPersonalInformation)! as bool;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isEditing)
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.done,
                    color: Color(0xFF2F80ED),
                    size: 17,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    context.l10n.save,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2F80ED),
                    ),
                  ),
                ],
              ),
            )
          else
            TextButton(
              onPressed: () {
                ref.read(editingPersonalInformation.notifier).changed =
                    !isEditing;
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  const Color(0xFF6968BE).withOpacity(0.3),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                      color: Color(0xFFE6EEFC),
                    ),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.edit_note_outlined,
                    color: Color(0xFF214687),
                    size: 17,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    context.l10n.edit,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF214687),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
