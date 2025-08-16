class LadderPositions {  
  int? ubicIni;
  int? ubicFin;
  int? pasos;

  LadderPositions({this.ubicIni, this.ubicFin, this.pasos});

  LadderPositions.fromJson(Map<String, dynamic> json) {    
    ubicIni = json['ubicIni'];
    ubicFin = json['ubicFin'];
    pasos = json['pasos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['ubicIni'] = this.ubicIni;
    data['ubicFin'] = this.ubicFin;
    data['pasos'] = this.pasos;
    return data;
  }
}

