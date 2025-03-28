import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:merge_music/core/common/global_state/access_token/access_token_cubit.dart';
import 'package:merge_music/core/constants/api_constants.dart';
import 'package:merge_music/core/utils/utils.dart';
import 'package:merge_music/presentation/vk_login/bloc/vk_login_bloc.dart';
import 'package:provider/provider.dart';

class VkLoginInputLoginPage extends StatefulWidget {
  const VkLoginInputLoginPage({super.key});

  @override
  State<VkLoginInputLoginPage> createState() => _VkLoginInputLoginPageState();
}

class _VkLoginInputLoginPageState extends State<VkLoginInputLoginPage> {
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
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(ApiConstants.oauthUrl),
          ),
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final url = navigationAction.request.url.toString();
            if (url.startsWith(ApiConstants.blankRedirectUri)) {
              final token = Utils.extractAccessToken(url);
              context.read<AccessTokenCubit>().updateToken(token);
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          },
        ),
      ),
    );
  }
}
