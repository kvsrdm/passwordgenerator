import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:toast/toast.dart';

class PasswordGenerate extends StatefulWidget {
  @override
  _PasswordGenerateState createState() => _PasswordGenerateState();
}

class _PasswordGenerateState extends State<PasswordGenerate> {
  bool isNumber = false;
  bool isUpperCase = false;
  bool isLowerCase = false;
  bool isSpecial = false;

  final passwordSize = TextEditingController();
  double pasSize;
  String passData = "";

  String passwordRating = "";
  int passwordStep = 0;

  @override
  Widget build(BuildContext context) {
    return passwordUI();
  }

  Widget passwordUI() {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFFecc780),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: passwordSize,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: "Boyut",
                          suffixIcon: Icon(Icons.add),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Color(0xFFe8b573),
                              ),
                              child: Checkbox(
                                activeColor: Color(0xFFe8b573),
                                value: isNumber,
                                onChanged: (value) {
                                  setState(() {
                                    isNumber = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Rakam",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFFe8b573))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Color(0xFFe8b573),
                              ),
                              child: Checkbox(
                                activeColor: Color(0xFFe8b573),
                                value: isUpperCase,
                                onChanged: (value) {
                                  setState(() {
                                    isUpperCase = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Büyük Harf",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFFe8b573))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Color(0xFFe8b573),
                              ),
                              child: Checkbox(
                                activeColor: Color(0xFFe8b573),
                                value: isLowerCase,
                                onChanged: (value) {
                                  setState(() {
                                    isLowerCase = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Küçük Harf",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFFe8b573))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Color(0xFFe8b573),
                              ),
                              child: Checkbox(
                                activeColor: Color(0xFFe8b573),
                                value: isSpecial,
                                onChanged: (value) {
                                  setState(() {
                                    isSpecial = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Özel karakter",
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFFe8b573))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: StepProgressIndicator(
                        totalSteps: 5,
                        currentStep: passwordStep,
                        selectedColor: Colors.green,
                        unselectedColor: Colors.black38,
                      ),
                    ),
                    Text(passwordRating, style: TextStyle(fontSize: 17)),
                  ],
                ),
                SizedBox(height: 10),
                SelectableText(passData),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (isLowerCase == true ||
                          isUpperCase == true ||
                          isNumber == true ||
                          isSpecial == true) {
                        if (passwordSize.text.isNotEmpty) {
                          pasSize = double.parse(passwordSize.text);
                          String generatedPassword = generatePassword(
                              isLowerCase,
                              isUpperCase,
                              isNumber,
                              isSpecial,
                              pasSize);
                          setState(() {
                            passData = generatedPassword;
                          });
                          if (pasSize < 13.0) {
                            passwordStep = 1;
                            passwordRating = "Zayıf";
                            print("Zayıf");
                          } else if (12.0 < pasSize && pasSize < 21.0) {
                            passwordStep = 3;
                            passwordRating = "Orta";
                            print("Orta");
                          } else if (21.0 < pasSize) {
                            passwordStep = 5;
                            passwordRating = "Güçlü";
                            print("Güçlü");
                          }
                        } else {
                          Toast.show("Geçersiz", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          print("Geçersiz");
                        }
                      } else {
                        Toast.show("Geçersiz", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                        print("Geçersiz");
                      }
                    });
                  },
                  child: Icon(Icons.refresh),
                  textColor: Color(0xFFe8b573),
                  color: Color(0xFFc26c5b),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    if (passData != "") {
                      Share.share(passData, subject: 'Sifre');
                    } else {
                      Toast.show("Şifre oluşturulmadı", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  },
                  child: Icon(Icons.share),
                  textColor: Color(0xFFe8b573),
                  color: Color(0xFFc26c5b),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String generatePassword(bool _isWithLetters, bool _isWithUppercase,
    bool _isWithNumbers, bool _isWithSpecial, double numberCharPassword) {
  String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
  String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String numbers = "0123456789";
  String special = "@#=+!£\$%&?[](){}";

  String _allowedChars = "";

  _allowedChars += (_isWithLetters ? lowerCaseLetters : '');
  _allowedChars += (_isWithUppercase ? upperCaseLetters : '');
  _allowedChars += (_isWithNumbers ? numbers : '');
  _allowedChars += (_isWithSpecial ? special : '');

  int i = 0;
  String _result = "";

  while (i < numberCharPassword.round()) {
    int randomInt = Random.secure().nextInt(_allowedChars.length);
    _result += _allowedChars[randomInt];
    i++;
  }

  return _result;
}
