import 'package:nvc_cinemas/feature/auth/provider/auth_provider.dart';
import 'package:nvc_cinemas/gen/assets.gen.dart';
import 'package:nvc_cinemas/gen/colors.gen.dart';
import 'package:nvc_cinemas/l10n/l10n.dart';
import 'package:nvc_cinemas/shared/widget/arrow_back_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpSuccessful extends ConsumerWidget {
  const SignUpSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final inset = MediaQuery.of(context).viewInsets;
    final height = size.height - (padding.top + padding.bottom + inset.bottom);
    final width = size.width - (padding.left + padding.right + inset.right);
    final ratio = height / size.width;

    return Scaffold(
      backgroundColor: ColorName.pageBackground,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  ArrowBackTitle(
                      title: context.l10n.signUp,
                      onPressed: () {
                        final email = ref
                            .read(authProvider)
                            .signUpForm
                            .control('email')
                            .value;
                        ref
                            .read(authProvider)
                            .loginForm
                            .control('email')
                            .value = email;
                        ref
                            .read(authProvider)
                            .loginForm
                            .control('password')
                            .value = '';
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/sign-in',
                          (route) => false,
                        );
                      }),
                  SizedBox(height: ratio < 1.95 ? 10 : 40),
                  if (ratio < 1.95)
                    const SizedBox(height: 20)
                  else
                    const Icon(
                      Icons.cloud_done_outlined,
                      size: 100,
                      color: Colors.green,
                    ),
                  SizedBox(height: ratio < 1.95 ? 10 : 25),
                  Text(
                    'Xin chúc mừng!',
                    style: const TextStyle(
                      fontSize: 19,
                      color: Color(0xFF4B5574),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    context.l10n.signInSuccessful,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4B5574),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ratio < 1.95 ? 50 : 150),
                  RoundedLoadingButton(
                    color: ColorName.primary,
                    borderRadius: 36,
                    height: 60,
                    width: size.width,
                    animateOnTap: false,
                    controller: ref.watch(authProvider).buttonController,
                    onPressed: () {
                      final email = ref
                          .read(authProvider)
                          .signUpForm
                          .control('email')
                          .value;
                      ref.read(authProvider).loginForm.control('email').value =
                          email;
                      ref
                          .read(authProvider)
                          .loginForm
                          .control('password')
                          .value = '';
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/sign-in',
                        (route) => false,
                      );
                    },
                    child: Text(
                      context.l10n.backToSignIn,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
