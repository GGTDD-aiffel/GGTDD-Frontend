class User {
  final int id; // int로 변경
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // 이제 int를 그대로 받음
      name: json['name'],
      email: json['email'],
    );
  }
}
