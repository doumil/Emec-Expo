import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsClass> litems = [];
  bool isLoading = true;
  void initState() {
    litems.clear();
    isLoading = true;
    _loadData();
    super.initState();
  }
  _loadData() async {
    //var url = "http://192.168.8.100/emecexpo/loadcongress.php";
    //var res = await http.post(Uri.parse(url));
    //List<NewsClass> news = (json.decode(res.body) as List)
      //  .map((data) => NewsClass.fromJson(data))
        //.toList();
    //litems=news;
    var ns1=NewsClass("MAGISTRI", "we have recovred the figure of the "
        "techer dressed in an innovative format : "
        "master classes with cinematographic quality");
    var ns2=NewsClass("MAGISTRI", "we have recovred the figure of the "
        "techer dressed in an innovative format : "
        "master classes with cinematographic quality");
    var ns3=NewsClass("MAGISTRI", "we have recovred the figure of the "
        "techer dressed in an innovative format : "
        "master classes with cinematographic quality");
    var ns4=NewsClass("MAGISTRI", "we have recovred the figure of the "
        "techer dressed in an innovative format : "
        "master classes with cinematographic quality");
    litems.add(ns1);
    litems.add(ns2);
    litems.add(ns3);
    litems.add(ns4);
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
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
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: isLoading == true
              ? Center(
              child: SpinKitThreeBounce(
                color: Color(0xff00c1c1),
                size: 30.0,
              ))
              : new ListView.builder(
              itemCount: litems.length,
              itemBuilder: (_, int position) {
                return new Card(
                  color: Colors.white,
                  shape: BorderDirectional(
                    bottom:BorderSide(color: Colors.black12, width: 1),
                  ),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Container(
                          //padding: EdgeInsets.only(bottom: height * 0.01),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/ICON-EMEC.png',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 80,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff261350),
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5.0),
                                    right: Radius.circular(5.0),
                                  ),
                                ),
                                width: double.maxFinite,
                                child: Text("  ${litems[position].title}",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(8,4, 0, 0),
                                child: Text("${litems[position].discription}\n"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
