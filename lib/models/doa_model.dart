class DoaListModel {
  int id;
  String grup;
  String nama;
  String ar;
  String tr;
  String idn;
  String tentang;
  List<String> tag;

  DoaListModel({
    required this.id,
    required this.grup,
    required this.nama,
    required this.ar,
    required this.tr,
    required this.idn,
    required this.tentang,
    required this.tag,
  });

  factory DoaListModel.fromJson(Map<String, dynamic> json) => DoaListModel(
    id: json["id"],
    grup: json["grup"],
    nama: json["nama"],
    ar: json["ar"],
    tr: json["tr"],
    idn: json["idn"],
    tentang: json["tentang"],
    tag: List<String>.from(json["tag"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grup": grup,
    "nama": nama,
    "ar": ar,
    "tr": tr,
    "idn": idn,
    "tentang": tentang,
    "tag": List<dynamic>.from(tag.map((x) => x)),
  };
}
