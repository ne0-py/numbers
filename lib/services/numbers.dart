import 'package:http/http.dart';
import 'dart:convert';

class TriviaService {
  String type;
  String number;
  List fact = [];

  TriviaService({required this.number, required this.type});

  Future<void> getData() async {
    try {
      for (var i = 0; i < 10; i++) {
        print("$number, $type");
        Response request = await get(
            Uri.parse("http://numbersapi.com/$number/$type?json=true"));

        Map data = jsonDecode(request.body);

        if (data['found'] == true) {
          if (!fact.contains(data['text'])) {
            fact.add(data['text']);
          }
        } else {
          fact = ["$number is cool, but not that cool"];
        }
      }
    } catch (e) {
      print(e);
      fact = ["An error has occured!"];
    }
  }
}
