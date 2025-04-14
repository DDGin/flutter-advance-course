import 'package:flutter/material.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.setting),
    );
  }
}
