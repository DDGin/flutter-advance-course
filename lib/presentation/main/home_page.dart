import 'package:flutter/material.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.home),
    );
  }
}
