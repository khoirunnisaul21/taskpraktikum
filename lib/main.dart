import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? _timer;
  int _time = 0;
  int _timeInput = 0;
  bool _isRunning = false;

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_time > 0) {
          _time--;
        } else {
          _timer?.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _timer?.cancel();
      _isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _time = _timeInput * 60; // Menggunakan nilai awal yang dimasukkan pengguna
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeString {
    final minutes = _time ~/ 60;
    final seconds = _time % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nama: Khoirun Nisaul Mufidah'),
            Text('NIM: 222410102004'),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Menit',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _timeInput = int.tryParse(value) ?? 0;
                          _time = _timeInput * 60; // Konversi menit menjadi detik
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      _time > 0 ? _timeString : 'WAKTU HABIS!',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _isRunning ? null : _startTimer,
                          child: Text('MULAI'),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? _stopTimer : null,
                          child: Text('BERHENTI'),
                        ),
                        ElevatedButton(
                          onPressed: _isRunning ? null : _resetTimer,
                          child: Text('MULAI ULANG'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
