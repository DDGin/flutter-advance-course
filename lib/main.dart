import 'package:flutter/material.dart';
import 'package:flutter_advance_course/app/app.dart';

import 'app/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Why it don't have "await" here
  initAppModule();
  runApp(MyApp());
}
