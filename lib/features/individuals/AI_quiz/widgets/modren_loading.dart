import 'dart:async';

import 'package:flutter/material.dart';

class ModernAnalysisLoader extends StatefulWidget {
  const ModernAnalysisLoader({super.key});

  @override
  State<ModernAnalysisLoader> createState() => _ModernAnalysisLoaderState();
}

class _ModernAnalysisLoaderState extends State<ModernAnalysisLoader> {
  int _index = 0;
  // UPDATED MESSAGES FOR QUIZ CONTEXT
  final List<String> _loadingMessages = [
    "Analyzing profile skills...",
    "Reviewing experience level...",
    "Curating challenge questions...",
    "Calibrating difficulty...",
    "Finalizing assessment...",
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Change text every 1.5 seconds
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        _index = (_index + 1) % _loadingMessages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Outer Glow Circle with Pulse Effect
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4285F4).withOpacity(0.2 * value),
                        blurRadius: 30 * value,
                        spreadRadius: 10 * value,
                      )
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                      backgroundColor: Color(0xFFEEF2FF),
                    ),
                  ),
                ),
              );
            },
            onEnd: () {}, // You can make this repeat if you wrap it in a StatefulWidget logic for pulse
          ),
          const SizedBox(height: 40),
          
          // Changing Text with AnimatedSwitcher
          SizedBox(
            height: 50,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0.0, 0.5), end: Offset.zero)
                        .animate(CurvedAnimation(
                            parent: animation, curve: Curves.easeOutBack)),
                    child: child,
                  ),
                );
              },
              child: Text(
                _loadingMessages[_index],
                key: ValueKey<int>(_index),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4B5563),
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}