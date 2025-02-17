import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class BackendBloc extends Cubit<String> {
  BackendBloc() : super('') {
    startFetchingData();
  }

  void startFetchingData() {
    Timer.periodic(Duration(milliseconds: 200), (timer) async {
      await fetchData();
    });
  }

  int prevState = 0;
  int litterDetected = 0;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.225.185:5000/api/data'));
    if (response.statusCode == 200) {
      emit(response.body);

      // int currentState = jsonDecode(response.body)['predictions'];
      // int stateDiff = currentState - prevState;
      //   // if (stateDiff >= 0) {
      //     litterDetected += (stateDiff);
      //     prevState = currentState;
      //
      //     print("Current litter: ${currentState}\nTotal litter: ${litterDetected}\nPrev litter: ${prevState}");
      //
      //   // }


    } else {
      emit('Failed to fetch data');
    }
    // print("HEKALS");

  }
}