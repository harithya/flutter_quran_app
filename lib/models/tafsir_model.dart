class TafsirModel {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  Map<String, String> audioFull;
  List<Tafsir> tafsir;

  TafsirModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.tafsir,
  });

  factory TafsirModel.fromJson(Map<String, dynamic> json) => TafsirModel(
    nomor: json["nomor"],
    nama: json["nama"],
    namaLatin: json["namaLatin"],
    jumlahAyat: json["jumlahAyat"],
    tempatTurun: json["tempatTurun"],
    arti: json["arti"],
    deskripsi: json["deskripsi"],
    audioFull: Map.from(
      json["audioFull"],
    ).map((k, v) => MapEntry<String, String>(k, v)),
    tafsir: List<Tafsir>.from(json["tafsir"].map((x) => Tafsir.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "namaLatin": namaLatin,
    "jumlahAyat": jumlahAyat,
    "tempatTurun": tempatTurun,
    "arti": arti,
    "deskripsi": deskripsi,
    "audioFull": Map.from(
      audioFull,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "tafsir": List<dynamic>.from(tafsir.map((x) => x.toJson())),
  };
}

class Tafsir {
  int ayat;
  String teks;

  Tafsir({required this.ayat, required this.teks});

  factory Tafsir.fromJson(Map<String, dynamic> json) =>
      Tafsir(ayat: json["ayat"], teks: json["teks"]);

  Map<String, dynamic> toJson() => {"ayat": ayat, "teks": teks};
}
