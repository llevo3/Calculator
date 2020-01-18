import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color (0xfffafafa), // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Color (0xfffafafa),
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 32.0;
  double resultFontSize = 40.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 32.0;
        resultFontSize = 40.0;
      }

      else if (buttonText == "⌫") {
        equationFontSize = 40.0;
        resultFontSize = 32.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }

      else if (buttonText == "=") {
        equationFontSize = 32.0;
        resultFontSize = 40.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('%', '* 0.01 *');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      }

      else {
        equationFontSize = 40.0;
        resultFontSize = 32.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget btnNumbers(String buttonText, double buttonHeight) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      child: FlatButton(
          shape: CircleBorder(side: BorderSide(
              color: Colors.transparent, width: 1.0, style: BorderStyle.solid)
          ),
          color: Colors.transparent,
          padding: EdgeInsets.all(0.0),
          onPressed: () => buttonPressed(buttonText),
          splashColor: Color(0x14000000),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey[850],
                fontFamily: 'Titillium'
            ),
          )
      ),
    );
  }

  Widget btnClear(String buttonText, double buttonHeight) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      child: FlatButton(
          shape: CircleBorder(side: BorderSide(
              color: Colors.transparent, width: 1.0, style: BorderStyle.solid)
          ),
          color: Color(0xffeeeeee),
          padding: EdgeInsets.all(0.0),
          onPressed: () => buttonPressed(buttonText),
          splashColor: Color(0x14000000),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.deepOrange,
                fontFamily: 'Titillium'
            ),
          )
      ),
    );
  }

  Widget btnFunction(String buttonText, double buttonHeight) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      child: FlatButton(
          shape: CircleBorder(side: BorderSide(
              color: Colors.transparent, width: 1.0, style: BorderStyle.solid)
          ),
          color: Color(0xeffeeeeee),
          padding: EdgeInsets.all(0.0),
          onPressed: () => buttonPressed(buttonText),
          splashColor: Color(0x14000000),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey[850],
                fontFamily: 'Titillium'
            ),
          )
      ),
    );
  }

  Widget btnEqual(String buttonText, double buttonHeight) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      child: FlatButton(
          shape: CircleBorder(
          ),
          color: Colors.pink,
          padding: EdgeInsets.all(0.0),
          onPressed: () => buttonPressed(buttonText),
          splashColor: Color(0x24ffffff),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontFamily: 'Titillium'
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // Add box decoration
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.pink,
                Colors.orange
              ],
            ),
          ),
          child: Column(
              children: <Widget>[

                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(14, 50, 14, 0),
                  child: Text(equation,
                    style: TextStyle(
                      fontSize: equationFontSize,
                      color: Colors.white54,
                      fontFamily: 'Titillium',
                    ),),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Text(result,
                    style: TextStyle(
                      fontSize: resultFontSize,
                      color: Colors.white,
                      fontFamily: 'Titillium',
                      fontWeight: FontWeight.bold,
                    ),),
                ),

                Expanded(
                  child: Divider(
                    color: Colors.transparent,
                  ),
                ),

                Container(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0))
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.only(
                          top: 0, bottom: 0, left: 12, right: 0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .75,
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                btnClear("C", 1),
                                btnFunction("⌫", 1),
                                btnFunction("%", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnNumbers("7", 1),
                                btnNumbers("8", 1),
                                btnNumbers("9", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnNumbers("4", 1),
                                btnNumbers("5", 1),
                                btnNumbers("6", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnNumbers("1", 1),
                                btnNumbers("2", 1),
                                btnNumbers("3", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnNumbers(".", 1),
                                btnNumbers("0", 1),
                                btnNumbers("00", 1),
                              ]
                          ),
                        ],
                      ),
                    ),

                    Container(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.only(
                          top: 0, bottom: 0, left: 0, right: 0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.25,
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                btnFunction("/", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnFunction("×", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnFunction("-", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnFunction("+", 1),
                              ]
                          ),

                          TableRow(
                              children: [
                                btnEqual("=", 1),
                              ]
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]
          ),
        )
    );
  }
}
