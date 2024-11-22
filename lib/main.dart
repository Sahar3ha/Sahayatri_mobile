import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/app.dart';
import 'package:sahayatri/core/networking/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService().init();

  runApp(
    const ProviderScope(child:SahayatriApp())
    );
}
