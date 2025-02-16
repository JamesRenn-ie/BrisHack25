import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
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

  Future<void> fetchData() async {
    // final response = await http.get(Uri.parse('http://192.168.192.68:5000/api/data'));
    final response = await http.get(Uri.parse('http://localhost:5000/api/data')); //Due to change
    if (response.statusCode == 200) {
      emit(response.body);
    } else {
      emit('Failed to fetch data');
    }
    // print("HEKALS");

  }
}