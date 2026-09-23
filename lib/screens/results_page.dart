import '../config.dart';
import 'package:flutter/material.dart';
import '../components/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String bmiResult = args["bmiResult"];
    final String resultText = args["resultText"];
    final String interpretion = args["interperation"];
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("BMI CALCULATOR"))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("Your Result", style: resultHeaderTextStyle),
                ),
              ),

              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 400.0,
                  color: activeColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(resultText, style: resultLabelTextStyle),

                      Text(bmiResult, style: resultTextStyle),
                      Text(
                        interpretion,
                        style: resultMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: BottomButton(
                  text: "Re-Calculate",
                  ontap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
