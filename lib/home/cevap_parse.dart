import 'package:ironydedection/home/cevap.dart';

class CevapParse {
  List<Cevap> donenCevap;
  CevapParse(
    this.donenCevap,
  );
  factory CevapParse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["cevap"] as List;
    List<Cevap> donenCevap = jsonArray
        .map((jsonAraayNesnesi) => Cevap.fromJson(jsonAraayNesnesi))
        .toList();
    return CevapParse(donenCevap);
  }
}
