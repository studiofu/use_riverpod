import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:use_riverpod/main.dart';

class Home1 extends StatelessWidget {
  const Home1({super.key});

// use consumer and builder to use the provider ////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home1'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final name = ref.watch(nameProvider);
        return Center(
          child: Text(name),
        );
      }),
    );
  }
}
