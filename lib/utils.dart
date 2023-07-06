import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum EnvironmentType {
  none('None', Colors.black),
  blue('Blue', Colors.blue),
  green('Green', Colors.green),
  red('Red', Colors.red);

  const EnvironmentType(this.name, this.color);
  final String name;
  final Color color;
}

class Environment {
  ValueNotifier<EnvironmentType> current = ValueNotifier(EnvironmentType.none);

  Environment() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      current.value = currentFlavors(packageInfo.packageName);
    });
  }
}

EnvironmentType currentFlavors(String packageName) {
  switch (packageName) {
    case "com.example.flavor_demo.blue":
      return EnvironmentType.blue;
    case "com.example.flavor_demo.green":
      return EnvironmentType.green;
    case "com.example.flavor_demo.red":
      return EnvironmentType.red;
    default:
      return EnvironmentType.none;
  }
}
