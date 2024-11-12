class Carrera {
  int? idCarrera;
  String? nameCarrera;

  Carrera({this.idCarrera, this.nameCarrera});

  factory Carrera.fromMap(Map<String, dynamic> map) {
    return Carrera(
      idCarrera: map['idCarrera'],
      nameCarrera: map['nameCarrera'],
    );
  }
}
