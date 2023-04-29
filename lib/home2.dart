import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:use_riverpod/main.dart';

class Home2 extends ConsumerWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final name = ref.watch(nameProvider);
    final name = ref.read(nameProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home2'),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
