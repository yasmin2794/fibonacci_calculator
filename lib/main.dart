import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fibonacci Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FibonacciPage(),
    );
  }
}

class FibonacciPage extends StatefulWidget {
  @override
  _FibonacciPageState createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
  TextEditingController _positionController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _positionController.dispose();
    super.dispose();
  }

  int fibonacci(int n, Map<int, int> memo) {
    if (n <= 0) return 0;
    if (n == 1) return 1;
    if (memo.containsKey(n)) return memo[n]!;

    memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
    return memo[n]!;
  }

  void calculateFibonacci() {
    int position = int.tryParse(_positionController.text) ?? 0;
    if (position < 0) {
      setState(() {
        _result = 'Please enter a non-negative integer.';
      });
      return;
    }

    int result = fibonacci(position, {});
    setState(() {
      _result = 'Fibonacci value at position $position is $result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fibonacci Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _positionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter position',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calculateFibonacci,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20.0),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
