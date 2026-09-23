import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_card.dart';
import '../components/reuseable_card.dart';
import '../config.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import '../calculate_brain.dart';

enum Gender { male, female }

enum ButtonMode { plus, minus }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  var selectedGender;
  int hieght = 180;
  int weight = 50;
  int age = 15;
  void ch(double n) {
    setState(() {
      hieght = n.round();
    });
  }

  //ButtonMode bm
  void addWeight() {
    setState(() {
      if (0 <= weight && weight < 150) {
        weight += 1;
      }
    });
  }

  void minusWeight() {
    setState(() {
      if (0 < weight && weight < 150) {
        weight -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('BMI CALCULATOR'))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                ReuseableCard(
                  clr: selectedGender == Gender.male
                      ? activeColor
                      : inactiveColor,
                  cardChild: IconCard(
                    label: "MALE",
                    icon: FontAwesomeIcons.mars,
                  ),
                  ontaped: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                ),
                ReuseableCard(
                  clr: selectedGender == Gender.female
                      ? activeColor
                      : inactiveColor,
                  cardChild: IconCard(
                    label: "FEMALE",
                    icon: FontAwesomeIcons.venus,
                  ),
                  ontaped: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              height: 250.0,

              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HIGHT", style: labelTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(hieght.toString(), style: inputTextStyle),
                      Text("cm", style: labelTextStyle),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15.0,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 25.0,
                      ),
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                    ),
                    child: Slider(
                      value: hieght.toDouble(),
                      onChanged: ch,
                      min: 120,
                      max: 220,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Row(
              children: [
                ReuseableCard(
                  clr: activeColor,
                  ontaped: () {},
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Weight", style: labelTextStyle),
                      Text(weight.toString(), style: inputTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                            child: FontAwesomeIcons.minus,
                            ontap: minusWeight,
                          ),
                          SizedBox(width: 10.0),
                          RoundIconButton(
                            child: FontAwesomeIcons.plus,
                            ontap: addWeight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ReuseableCard(
                  clr: activeColor,
                  ontaped: () {},
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("AGE", style: labelTextStyle),
                      Text(age.toString(), style: inputTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                            child: FontAwesomeIcons.minus,
                            ontap: () {
                              setState(() {
                                if (0 < age && age < 120) {
                                  age -= 1;
                                }
                              });
                            },
                          ),
                          SizedBox(width: 10.0),
                          RoundIconButton(
                            child: FontAwesomeIcons.plus,
                            ontap: () {
                              setState(() {
                                if (0 <= age && age < 120) {
                                  age += 1;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            text: "CALCULATE",
            ontap: () {
              CalculateBrain calculator = CalculateBrain(
                height: hieght,
                weight: weight,
              );
              Navigator.pushNamed(
                context,
                '/results',
                arguments: {'bmiResult': calculator.calculateBMI(), 'resultText': calculator.getResult(), 'interperation': calculator.getInterpretion()},
              );
            },
          ),
        ],
      ),
    );
  }
}
