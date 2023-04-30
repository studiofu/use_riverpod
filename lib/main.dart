import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:use_riverpod/home2.dart';
import 'package:use_riverpod/user.dart';

import 'home1.dart';
import 'package:http/http.dart' as http;

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
          const User(name: '', gender: 'M'),
        ));

// another type, change notifier provider
// migrated from Provider user

// FutureProvider
final fetchUserProvider = FutureProvider((ref) {
  const url = 'https://jsonplaceholder.typicode.com/users/1';
  // http.get return future of repsonse,
  // after then , return future of User
  return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
});

// create a refence to UserRepository
final UserRepositoryProvider = Provider((ref) => UserRepository());

// create ref to UserRepository and use it to get the future value
// provider links to another provider.
final fetchUserProvider2 = FutureProvider((ref) {
  final userRepository = ref.watch(UserRepositoryProvider);
  return userRepository.fetchUserData();
});

// family usage, to pass one argument ...
var a = Provider.family((ref, arg) => null);
var b = Provider.family.autoDispose((ref, arg) => null);

// test stream provider
final streamProvider = StreamProvider(
  (ref) async* {
    // produce stream of data
    sleep(Duration(seconds: 2));
    yield [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    sleep(Duration(seconds: 2));
    yield 123;
    sleep(Duration(seconds: 2));
    yield 111;
  },
);

// provider observe, please refer to logger_riverpod.dart
// add to the observers in ProviderScope

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
    observers: [],
  ));
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

        final futureUser = ref.watch(fetchUserProvider2);

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
              child: Text(updatedname!),
            ),
            UserWidget(),

            // access to future provider value
            futureUser.when(
              data: (data) {
                return Text(data.name!);
              },
              error: (error, stackTrace) {
                print(error);
                return CircularProgressIndicator();
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),

            ref.watch(streamProvider).when(
              data: (data) {
                //data
                return Text(data.toString());
              },
              error: (error, stackTrace) {
                print(error);
                //error
                return CircularProgressIndicator();
              },
              loading: () {
                //loading
                return CircularProgressIndicator();
              },
            )
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
