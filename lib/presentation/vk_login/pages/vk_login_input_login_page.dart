import 'package:flutter/material.dart';
import 'package:merge_music/core/extensions/extensions.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:merge_music/presentation/vk_login/widgets/vk_login_button.dart';
import 'package:provider/provider.dart';

class VkLoginInputLoginPage extends StatefulWidget {
  const VkLoginInputLoginPage({super.key});

  @override
  State<VkLoginInputLoginPage> createState() => _VkLoginInputLoginPageState();
}

class _VkLoginInputLoginPageState extends State<VkLoginInputLoginPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<VkLoginBloc>().add(const GoBack());
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.l10n.signInVk, style: context.text.largeTitle),
              const SizedBox(
                height: 8,
              ),
              Form(
                child: TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: context.l10n.textFieldLoginLabel,
                    labelStyle: context.text.subtitle,
                  ),
                ),
              ),
              Form(
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.textFieldPasswordLabel,
                    labelStyle: context.text.subtitle,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              VkLoginButton(
                onTap: () {
                  context.read<VkLoginBloc>().add(
                        TapSignInButton(
                            login: _loginController.text,
                            password: _passwordController.text),
                      );
                },
                label: context.l10n.continueLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
