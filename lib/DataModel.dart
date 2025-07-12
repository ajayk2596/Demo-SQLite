class DataModel{
  int? id;
  String name;
  String image;
  DataModel({ this.id,required this.name,required this.image});

  factory DataModel.fromJson(Map<String,dynamic> json){
    return DataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}