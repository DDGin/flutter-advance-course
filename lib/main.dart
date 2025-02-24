import 'package:flutter/material.dart';
import 'package:flutter_advance_course/app/app.dart';

import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Why it don't have "await" here
  await initAppModule();
  runApp(MyApp());
}
