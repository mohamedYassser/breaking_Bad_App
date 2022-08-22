import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp( MyApp(

    appRouter:AppRouter(),

  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({ required this.appRouter});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
onGenerateRoute: appRouter.generateRoute,
    );
  }
}
