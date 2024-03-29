import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _minutes = 0;
  Timer? _timer;
  bool _isStarted = false;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_minutes > 0) {
        setState(() {
          _minutes--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isStarted = false;
        });
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _isStarted = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _minutes = 0;
      _isStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _minutes.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Masukan Menit',
                    ),
                    onChanged: (value) {
                      _minutes = int.parse(value);
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _isStarted ? null : startTimer,
                  child: const Text('MULAI'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _isStarted ? stopTimer : null,
                  child: const Text('BERHENTI'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text('MULAI ULANG'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              _minutes > 0 ? '$_minutes Menit' : 'WAKTU HABIS!',
              style: const TextStyle(fontSize: 48.0),
            ),
          ],
        ),
      ),
    );
  }
}
