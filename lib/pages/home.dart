import 'package:flutter/material.dart';
import 'package:numbers/widgets/cards.dart';
import 'package:numbers/services/numbers.dart';
import 'package:numbers/pages/loading.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  String hintText = 'Numberr...';
  String number = 'random';
  String selectedParam = 'trivia';
  String loadingMessage = 'Rolling the dice...';
  List params = ['year', 'trivia', 'math', 'date'];
  List facts = [];

  void loadCards() async {
    setState(() {
      isLoading = true;
    });

    TriviaService request =
        await TriviaService(number: number, type: selectedParam);
    await request.getData();

    setState(() {
      facts = request.fact;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading(loadingMessage: loadingMessage)
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Numberr",
                        style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: TextFormField(
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search_rounded),
                                hintText: hintText,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onChanged: (val) {
                              if (val == ".") {
                                number = "random";
                              } else if (val.contains(',')) {
                                number = val.replaceAll(RegExp(r','), '/');
                              } else {
                                number = val;
                              }
                            },
                            onFieldSubmitted: (val) {
                              if (val == ".") {
                                number = "random";
                              } else if (val.contains(',')) {
                                number = val.replaceAll(RegExp(r','), '/');
                              } else {
                                number = val;
                              }
                              loadCards();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 60,
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              hint: Text("Search By"),
                              onChanged: (val) {
                                selectedParam = val.toString();
                                setState(() {
                                  switch (selectedParam) {
                                    case 'date':
                                      hintText = 'Month,Day';
                                      loadingMessage = 'Is it your birthdate?';
                                      break;
                                    case 'trivia':
                                      hintText = "# or . for random";
                                      loadingMessage = "Rolling the dice...";
                                      break;
                                    default:
                                      hintText = 'Numberr...';
                                      loadingMessage = "Beep Bop Boop";
                                  }
                                });
                              },
                              items: params
                                  .map((param) => DropdownMenuItem(
                                      value: param,
                                      child: Text(
                                          "${param.toString().replaceRange(0, 1, param.toString().substring(0, 1).toUpperCase())}")))
                                  .toList()),
                        ),
                        IconButton(
                            onPressed: loadCards,
                            icon: Icon(Icons.refresh_rounded)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("RESULTS FOR",
                          style:
                              TextStyle(fontSize: 12, fontFamily: "Raleway")),
                    ),
                    Center(
                      child: Text(
                        "${number.toString().replaceRange(0, 1, number.toString().substring(0, 1).toUpperCase())} in ${selectedParam.toString().replaceRange(0, 1, selectedParam.toString().substring(0, 1).toUpperCase())}",
                        style: TextStyle(fontSize: 24, fontFamily: "Raleway"),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Cards(facts: facts),
                    SizedBox(height: 15),
                    Center(
                      child: Text(
                        "Powered by NUMBERSAPI.com",
                        style: TextStyle(fontFamily: "Raleway", fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
