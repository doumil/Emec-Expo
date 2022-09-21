import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool _isEnabled=true;

  void initState() {
    super.initState();
  }
  _onChanged() {
    setState(() {
      _isEnabled = !_isEnabled;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Êtes-vous sûr'),
            content: new Text('Voulez-vous quitter une application'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Non'),
              ),
              new TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Oui '),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    child: Column(children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(width * 0.045, 0, 0, 0),
                            child: Checkbox(
                              value: isChecked1,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked1 = value!;
                                  if(isChecked1==false)
                                    {
                                      _onChanged();
                                    }
                                  else{
                                    _isEnabled=true;
                                  }
                                });
                              },
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Text('Receive Notification',
                                style: TextStyle(fontSize: height * 0.022))),
                      ])),
                      Container(),
                      Container(
                          child: Row(children: <Widget>[
                        Container(
                            padding:
                                EdgeInsets.fromLTRB(width * 0.045, 0, 0, 0),
                            child: Checkbox(
                              value: isChecked2,
                              onChanged: _isEnabled?
                                  (bool? value) {
                                setState(() {
                                  isChecked2 = value!;
                                  HapticFeedback.vibrate();
                                });
                              }
                              :null,
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Text('Vibrate',
                                style: TextStyle(fontSize: height * 0.022,))),
                      ])),
                      Container(
                          child: Row(children: <Widget>[
                        Container(
                            padding:
                                EdgeInsets.fromLTRB(width * 0.045, 0, 0, 0),
                            child: Checkbox(
                              value: isChecked3,
                              onChanged: _isEnabled?
                                  (bool? value) {
                                setState(() {
                                  isChecked3 = value!;

                                });
                              }
                                  :null,
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Text('Blink LED',
                                style: TextStyle(fontSize: height * 0.022))),
                      ])),
                    ]),
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(top: height * 0.01),
            padding: EdgeInsets.only(bottom: height * 0.02, top: height * 0.02),
            width: width * 0.9,
          ),
        ));
  }
}