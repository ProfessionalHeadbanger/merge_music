class VkLoginResponseModel {
  const VkLoginResponseModel();

  factory VkLoginResponseModel.success(
      {required String accessToken,
      required String secret}) = VkLoginResponseModelSuccess;
  factory VkLoginResponseModel.needValidation(
      {required String validationSid,
      required String phoneMask,
      required String redirectUri}) = VkLoginResponseModelNeedValidation;
}

class VkLoginResponseModelSuccess extends VkLoginResponseModel {
  final String accessToken;
  final String secret;

  const VkLoginResponseModelSuccess({
    required this.accessToken,
    required this.secret,
  });
}

class VkLoginResponseModelNeedValidation extends VkLoginResponseModel {
  final String validationSid;
  final String phoneMask;
  final String redirectUri;

  const VkLoginResponseModelNeedValidation({
    required this.validationSid,
    required this.phoneMask,
    required this.redirectUri,
  });
}
