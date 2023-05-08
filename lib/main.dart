import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
     theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38;
  double resultFontSize = 48;


  buttonPressed(String buttonText){
    setState(() {

      if (buttonText == 'C') {
         equation = '0';
         result = '0';
         equationFontSize = 38;
         resultFontSize = 48;
      }
      else if (buttonText == '⌫') {
        //This changes the font size of the equation and result
        equationFontSize = 48;
        resultFontSize = 38;

        //This clears the values one after the other
        equation = equation.substring(0, equation.length - 1);

         //This returns 0 when clearing using ⌫ and the equation is empty
        if(equation == ''){
          equation = '0';
         }
      }

      else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;

        //This does the calculation
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        //This handles calculation and any error that may arise during calculation
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch(e) {
          result = 'Error';
        }

      }

      else {
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == '0') {
        equation = buttonText;
      }
      else {
        equation = equation + buttonText;
      }
    }
    });

  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,  // Set the background color of the button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: const BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Simple Calculator'),
      ),
      body: Column(
        children:  <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),
          const Expanded(child: Divider(),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('C', 1, Colors.redAccent),
                      buildButton('⌫', 1, Colors.blue),
                      buildButton('÷', 1, Colors.blue),
                    ]
                    ),
                    TableRow(children: [
                      buildButton('7', 1, Colors.black54),
                      buildButton('8', 1, Colors.black54),
                      buildButton('9', 1, Colors.black54),
                    ]
                    ),
                    TableRow(children: [
                      buildButton('4', 1, Colors.black54),
                      buildButton('5', 1, Colors.black54),
                      buildButton('6', 1, Colors.black54),
                    ]
                    ),
                    TableRow(children: [
                      buildButton('1', 1, Colors.black54),
                      buildButton('2', 1, Colors.black54),
                      buildButton('3', 1, Colors.black54),
                    ]
                    ),
                    TableRow(children: [
                      buildButton('.', 1, Colors.black54),
                      buildButton('0', 1, Colors.black54),
                      buildButton('00', 1, Colors.black54),
                    ]
                    ),
                  ],


                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('*', 1, Colors.blue),
                ]
                    ),
                    TableRow(children: [
                      buildButton('-', 1, Colors.blue),
                    ]
                    ),
                    TableRow(children: [
                      buildButton('+', 1, Colors.blue),
                    ]
                    ),
                    TableRow(children: [
                      buildButton('=', 2, Colors.redAccent),
                    ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
