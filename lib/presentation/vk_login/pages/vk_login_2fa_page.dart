import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:merge_music/presentation/vk_login/widgets/vk_login_button.dart';

class VkLogin2faPage extends StatefulWidget {
  const VkLogin2faPage({super.key});

  @override
  State<VkLogin2faPage> createState() => _VkLogin2faPageState();
}

class _VkLogin2faPageState extends State<VkLogin2faPage> {
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<VkLoginBloc>().add(const Request2faEvent());
  }

  @override
  void dispose() {
    _codeController.dispose();
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
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Код из SMS"),
              ),
              const SizedBox(height: 24),
              VkLoginButton(
                onTap: () {
                  context.read<VkLoginBloc>().add(
                        SendSmsCode(
                          code: _codeController.text,
                        ),
                      );
                },
                label: "Подтвердить",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
