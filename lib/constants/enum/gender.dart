enum Gender { male, female }

extension GenderType on Gender {
  String get key {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
  }

  String get name {
    switch (this) {
      case Gender.male:
        return 'signup_mg4';
      case Gender.female:
        return 'signup_mg5';
    }
  }
}
