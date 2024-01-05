import 'package:flutter/material.dart';

import '../core/functions/testrating.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RatingDialog(),
    );
  }
}
