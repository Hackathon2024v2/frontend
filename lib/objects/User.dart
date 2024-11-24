class UserData {
  late int id;
  late String first_name;
  late String last_name;
  late String prefix;
  late String height;
  late String weight;
  late int score;
  late String avatar;
  late int year;


  UserData({
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

  // Method to create a User object from a Map (e.g., from userMetadata)
  UserData.fromMetadata(Map<String, dynamic>? metadata) {
    id = metadata?['id'] ?? 0; // Default value if not present
    first_name =
        metadata?['first_name'] ?? ''; // Default empty string if not present
    last_name = metadata?['last_name'] ?? '';
    prefix = metadata?['prefix'] ?? '';
    height = metadata?['height'].toString() ?? '0.0'; // Ensure height is a double
    weight = metadata?['weight'].toString() ?? '0.0'; // Ensure weight is a double
    score = metadata?['score'] ?? 0;
    avatar = metadata?['avatar'] ?? '';
    year = metadata?['year'] ?? 0;
  }

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
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