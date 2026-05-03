// onboarding_screen.dart

import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding Questionnaire')), 
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Step1(),
          Step2(),
          Step3(),
          Step4(),
          Step5(),
          Step6(),
        ],
      ),
    );
  }
}

class Step1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(16), child: Text('1. Select your Goal:')));
  }
}

class Step2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(16), child: Text('2. Level Selection: Beginner, Intermediate, Advanced')));
  }
}

class Step3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(16), child: Text('3. Frequency: Daily, 3-4 times/week, Weekends')));
  }
}

class Step4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(16), child: Text('4. Preferred Time: Morning, Afternoon, Night')));
  }
}

class Step5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(16), child: Text('5. Working Style: Chill, Structured, Competitive')));
  }
}

class Step6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(16), child: Text('6. Collaboration: Chat, Calls, Check-ins with progress bar and navigation to SwipeScreen')));
  }
}

void main() {
  runApp(MaterialApp(home: OnboardingScreen()));
}