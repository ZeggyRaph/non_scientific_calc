import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Column(
        children:  <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: const Text('0', style: TextStyle(fontSize: 38),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: const Text('0', style: TextStyle(fontSize: 48),),
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
                      Container(
                        height: MediaQuery.of(context).size.height * .1,
                        color: Colors.redAccent,
                        child: ElevatedButton(

                          style:
                          ElevatedButton.styleFrom(
                            shape:
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              style: BorderStyle.solid),),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: null,
                          child: const Text('C',
                            style: TextStyle(
                                fontSize:30,
                            fontWeight: FontWeight.normal,
                            color: Colors.white
                              ),),

                        ),
                      ),])],

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
