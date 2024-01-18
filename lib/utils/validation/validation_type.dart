
import 'validation.dart';

class Validate {
  const Validate({required this.func, this.msgValid, this.msgInValid});
  final bool Function(String str) func;
  final String? msgValid;
  final String? msgInValid;
}

enum ValidationType { email, password }

extension GetValidationRegex on ValidationType {
  Validate get value {
    Validate validate;
    switch (this) {
      case ValidationType.password:
        validate = const Validate(
          func: ValidationRegex.isValidPassword,
          msgValid: 'Mật khẩu hợp lệ.',
          msgInValid: 'Mật khẩu không hợp lệ.',
        );
        break;
      case ValidationType.email:
        validate = const Validate(
          func: ValidationRegex.isValidEmail,
          msgValid: 'Email hợp lệ.',
          msgInValid: 'Email không hợp lệ.',
        );
        break;
    }
    return validate;
  }
}
