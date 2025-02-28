import 'package:flutter/material.dart';
import 'dart:math';
import 'info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _bmi = 0.0;
  var _weight = 0.0;
  var _height = 0.0;
  var _bmiOutput = '';
  var _bmiImage = 'assets/images/empty.png';
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  void _calculate() {
    _weight = double.tryParse(_weightCtrl.text)!;
    _height = double.tryParse(_heightCtrl.text)!;

    setState(() {
      _bmi = _weight / pow(_height, 2);

      if (_bmi < 18.5) {
        _bmiImage = 'assets/images/under.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Underweight]';
      }
      else if (_bmi >= 25) {
        _bmiImage = 'assets/images/over.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Overweight]';
      }
      else {
        _bmiImage = 'assets/images/normal.png';
        _bmiOutput = '${_bmi.toStringAsFixed(2)} [Normal]';
      }
    });
  }

  void _reset() {
    _weightCtrl.clear();
    _heightCtrl.clear();
    setState(() {
      _bmi = 0.0;
      _bmiOutput = '';
      _bmiImage = 'assets/images/empty.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(_bmiImage),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: _bmi == 0.0 ? Text(
                      'Enter body weight and height to know your Body Mass Index (BMI)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange),
                    ) : Text(''),
                  ),
                ],
              ),
              Text('Your Body Mass Index (BMI) is:'),
              Text(
                _bmiOutput,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              TextField(
                controller: _weightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter weight (kg)',
                ),
              ),
              TextField(
                controller: _heightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter height (m)',
                ),
              ),
              Expanded(child: SizedBox()),

              // TODO 12: IconButton
              IconButton(
                icon: Icon(Icons.info),
                iconSize: 48,
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Info(bmi: _bmiOutput)),
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _reset,
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                      onPressed: _calculate,
                      child: Text('Calculate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
