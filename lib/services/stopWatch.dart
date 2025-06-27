import 'dart:async';
import 'package:flutter/material.dart';

class SimpleStopwatch extends StatefulWidget {
  const SimpleStopwatch({super.key});

  @override
  State<SimpleStopwatch> createState() => _SimpleStopwatchState();
}

class _SimpleStopwatchState extends State<SimpleStopwatch> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  String _formattedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        final elapsed = _stopwatch.elapsed;
        _formattedTime =
        "${_twoDigits(elapsed.inMinutes)}:${_twoDigits(elapsed.inSeconds % 60)}:${_twoDigits((elapsed.inMilliseconds ~/ 10) % 100)}";
      });
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _stopwatch.stop();
    _timer.cancel();
    setState(() {
      _formattedTime = "00:00:00";
    });
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _formattedTime,
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _stopwatch.isRunning ? null : _startStopwatch,
              child: const Text('Start'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _stopwatch.isRunning ? _stopStopwatch : null,
              child: const Text('Stop'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _resetStopwatch,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}
