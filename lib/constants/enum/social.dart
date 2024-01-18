
enum Social { kakao, naver, google }

extension ScocialType on Social {
  String get name {
    switch (this) {
      case Social.kakao:
        return 'kakao';
      case Social.naver:
        return 'naver';
      case Social.google:
        return 'google';
    }
  }
}
