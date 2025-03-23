import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:merge_music/presentation/vk_login/widgets/vk_login_button.dart';
import 'package:provider/provider.dart';

class VkLoginWelcomePage extends StatelessWidget {
  const VkLoginWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.welcome,
                style: context.text.largeTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                context.l10n.loginVk,
                style: context.text.smallTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              VkLoginButton(
                label: context.l10n.signIn,
                onTap: () {
                  context.read<VkLoginBloc>().add(const OpenInputLoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
