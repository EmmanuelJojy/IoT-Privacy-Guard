import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/data/shared.dart';

Future<Status> fetchInitialStatus() async {
  // print('http://${SharedData.ip}/');
  final response = await http.get(Uri.parse('http://${SharedData.ip}/'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Status.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Status');
  }
}

Future<Status> fetchStatus(String id) async {
  // print('http://${SharedData.ip}/LED/$id/$state');
  final response =
      await http.get(Uri.parse('http://${SharedData.ip}/$id'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Status.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Status');
  }
}

Future<void> initialRefresh() async {
  //SharedData.status = await fetchInitialStatus();
}

Future<void> refresh(int id) async {
  SharedData.status = await fetchStatus(id == 1 ? "IN" : "ST");
}