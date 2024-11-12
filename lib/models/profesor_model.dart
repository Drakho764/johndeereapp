class Profesor {
  int? idProfe;
  String? nameProfe;
  int? idCarrera;
  String? email;

  Profesor({this.idProfe, this.nameProfe, this.idCarrera, this.email});

  factory Profesor.fromMap(Map<String, dynamic> map) {
    return Profesor(
      idProfe: map['idProfe'],
      nameProfe: map['nameProfe'],
      idCarrera: map['idCarrera'],
      email: map['email'],
    );
  }
}
