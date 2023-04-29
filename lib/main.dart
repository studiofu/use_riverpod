import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:use_riverpod/home2.dart';
import 'package:use_riverpod/user.dart';

import 'home1.dart';

// create provider
final countProvider = Provider<int>(
  (ref) => 3,
);

// name provider //////////
final nameProvider = Provider(
  // ref is a object able to talk with other providers
  (ref) {
    // return something;
    return 'Author Name';
  },
);

// state provider ////////////
final nameStateProvider = StateProvider<String?>((ref) => 'State Name');

// update complex object ////////
// need to use state provider and state notifier provider
// create model and the model notifier

// final userProvider = StateNotifierProvider(
//     (ref) => UserNotifier(User(name: '', age: 0, gender: 'M')));

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier(
          const User(name: '', age: 0, gender: 'M'),
        ));

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// update provider value
// need to read provider notifier
void onSubmit(WidgetRef ref, String value) {
  // handling on submit
  ref.read(nameStateProvider.notifier).update((state) => state! + value);
}

class _MyWidgetState extends State<MyWidget> {
  // or use ConsumreState<MyWidget>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful'),
      ),
      body: Consumer(builder: (context, ref, child) {
        User user = ref.watch(userProvider);

        // only rebuild the widget when there is a value change for a particular field
        final updatedname =
            ref.watch(userProvider.select((value) => value.name));

        final name = ref.watch(nameStateProvider) ?? '';

        return Column(
          children: [
            Center(
              child: Text(name),
            ),
            TextField(
              // need to pass ref to use
              onSubmitted: (value) => onSubmit(ref, value),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: Colors.black),
              child: InkWell(
                onTap: () {
                  ref.read(userProvider.notifier).updateName('Hello');
                },
              ),
            ),
            Center(
              child: Text(updatedname),
            ),
            Center(
              child: Text(user.age.toString()),
            ),
            UserWidget(),
          ],
        );
      }),
    );
  }
}

class UserWidget extends ConsumerWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
