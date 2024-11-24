class User {
  late int id;
  late String first_name;
  late String last_name;
  late String prefix;
  late double height;
  late double weight;
  late int score;
  late String avatar;
  late int year;


  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.prefix,
    required this.height,
    required this.weight,
    required this.score,
    required this.avatar,
    required this.year,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['int'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    prefix = json['prefix'];
    height = json['height'];
    weight = json['weight'];
    score = json['score'];
    avatar = json['avatar'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['prefix'] = prefix;
    data['height'] = height;
    data['weight'] = weight;
    data['avatar'] = avatar;
    data['year'] = year;

    return data;
  }

}