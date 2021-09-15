import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ironydedection/home/cevap.dart';
import 'package:ironydedection/home/cevap_parse.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late String ironySonuc = "";
  late String ironyYuzde = "";
  late String girilenMetin = "";
  final myController = TextEditingController();

  List<Cevap> parseCevap(String cevap) {
    var jsonVeri = json.decode(cevap);
    var gelenCevap = CevapParse.fromJson(jsonVeri);
    List<Cevap> donenCevap = gelenCevap.donenCevap;
    return donenCevap;
  }

  Future<List<Cevap>> cevap() async {
    girilenMetin = myController.text;
    var url = "http://10.0.2.2:5000/" + "$girilenMetin";
    var cevap = await http.get(Uri.parse(url));
    print(cevap.body);
    return parseCevap(cevap.body);
  }

  Future<void> cevapGoster() async {
    var liste = await cevap();
    for (var k in liste) {
      print("*" * 10);
      print("Sonuç : ${k.sonuc}");
      print("Yüzde : ${k.yuzde}");
      ironySonuc = "${k.sonuc}";
      ironyYuzde = "The probability of being irony is ${k.yuzde}%";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    bilgilendiriciYazi(),
                    textField(),
                    buton(),
                    sonucKismi()
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://andreasgrosz.com/wp-content/uploads/2020/08/geometry2.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ), //Offset
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              width: size.width * 0.9,
              height: size.height * 0.55,
            ),
            SizedBox(height: 10),
            gif(size),
          ],
        ),
      ),
    );
  }

  Column bilgilendiriciYazi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Irony Detection System",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          "Investigating the Neural Models for Irony Detection on Enghlish Informal Texts.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 22),
        Text(
          "Enter Text Here:",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text("If the probability is below 50 percent, it's not irony.")
      ],
    );
  }

  Padding textField() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 5),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  RaisedButton buton() {
    return RaisedButton(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      color: Colors.blue.shade800,
      onPressed: () {
        cevapGoster();
      },
      child: Text(
        "Submit",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Column sonucKismi() {
    return Column(
      children: [
        Text(
          ironyYuzde,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          ironySonuc,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Image gif(Size size) {
    return Image.network(
      "https://static.tildacdn.com/tild3431-3132-4261-b363-363132366562/giphy.gif",
      width: size.width * 0.7,
      height: size.height * 0.3,
    );
  }
}
