class SnakePositions {  
  int? ubicIni;
  int? ubicFin;
  

  SnakePositions({this.ubicIni, this.ubicFin});

  SnakePositions.fromJson(Map<String, dynamic> json) {    
    ubicIni = json['ubicIni'];
    ubicFin = json['ubicFin'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['ubicIni'] = this.ubicIni;
    data['ubicFin'] = this.ubicFin;    
    return data;
  }
}