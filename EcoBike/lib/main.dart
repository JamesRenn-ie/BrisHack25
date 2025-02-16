import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'backend_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco-Bike',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => BackendBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eco-Bike")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<BackendBloc, String>(
              builder: (context, state) {
                if (state.isEmpty) {
                  return Text("Press the button to fetch data");
                }
                return Text(state);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<BackendBloc>().fetchData();
              },
              child: Text("Fetch Data"),
            ),
          ],
        ),
      ),
    );
  }
}
