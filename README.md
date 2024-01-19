# base

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# install gen image
## Macos and Linux

```shell script
brew install FlutterGen/tap/fluttergen
dart pub global activate flutter_gen
```

# build gen
``` shell script
[fvm] flutter pub run build_runner build --delete-conflicting-outputs
```

# Create assets.gen.dart run shell when call shell generate above
``` shell script
fluttergen -c pubspec.yaml
```

### Debug

```shell script
flutter run --debug --flavor development -t lib/mains/main_development.dart
flutter run --debug --flavor staging -t lib/mains/main_staging.dart
flutter run --debug --flavor production -t lib/mains/main_production.dart
```

### Changed icon app
```shell script
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*
```

### Changed splash screen app
```shell script
dart run flutter_native_splash:create --flavors flutter_native_splash*
```

### Gen Key Hash Android

```shell script
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64
```

# Build apk
```
flutter build apk --debug --flavor experiment -t lib/main/main_experiment.dart
```

# IOS clean
``` rm -rf Pods
rm -rf Podfile.lock
rm -rf ~/.pub-cache/hosted/pub.dartlang.org/
pod cache clean --all
flutter clean
flutter pub get
pod repo update
```


# config Firebase CLI
```
1 - curl -sL https://firebase.tools | bash
2 - firebase login
3 - firebase projects:list (optional)
4 - flutterfire config \--project=${Project ID} \--out=lib/generated/firebase_options.dart \--ios-bundle-id=com.example.todoBloc \--macos-bundle-id=com.example.todoBloc \--android-package-name=com.example.sendlib

Project ID: you can see that by firebase projects:list or check directly on your firebase console
```

### Release

```shell script
flutter run --release --flavor development -t lib/mains/main_development.dart
flutter run --release --flavor staging -t lib/mains/main_staging.dart
flutter run --release --flavor production -t lib/mains/main_production.dart
```

