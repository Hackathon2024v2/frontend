import 'User.dart';

class ProfileUser extends User {
  final String emotion;
  final String intelligence;
  final String objective;
  final String type;
  final String sex;
  final String age;
  final String weight;
  final String level;
  final int previousLevelScore;
  final int nextLevelScore;

  ProfileUser({
    required super.username,
    required super.prefix,
    required super.height,
    required super.score,
    required this.emotion,
    required this.intelligence,
    required this.objective,
    required this.type,
    required this.sex,
    required this.age,
    required this.weight,
    required this.level,
    required this.previousLevelScore,
    required this.nextLevelScore,
  });
}

var userPlaceholder = ProfileUser(username: 'Johnny Test', sex: "Mâle", prefix: 'Monsieur',
    height: 1.76, score: 14900, emotion: 'Fâché', intelligence: 'Génie', objective: 'Force', type: "Gorille", age: "22", weight: '50', level: '18', previousLevelScore: 12000, nextLevelScore: 16000);