class Preguntas {
  int? codPregunta;
  String? tituloPregunta;
  String? pregunta;
  int? nroTragos;
  int? codCategoria;

  Preguntas(
      {this.codPregunta,
      this.tituloPregunta,
      this.pregunta,      
      this.codCategoria});

  Preguntas.fromJson(Map<String, dynamic> json) {
    codPregunta = json['codPregunta'];
    tituloPregunta = json['tituloPregunta'];
    pregunta = json['pregunta'];    
    codCategoria = json['codCategoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codPregunta'] = this.codPregunta;
    data['tituloPregunta'] = this.tituloPregunta;
    data['pregunta'] = this.pregunta;    
    data['codCategoria'] = this.codCategoria;
    return data;
  }
}