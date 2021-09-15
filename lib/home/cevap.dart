class Cevap {
  String sonuc;
  String yuzde;
  Cevap(
    this.sonuc,
    this.yuzde,
  );
  factory Cevap.fromJson(Map<String, dynamic> json) {
    return Cevap(json["sonuc"], json["yuzde"]);
  }
}
