class User {
  final int id;
  final String name;
  final String lastname;
  final int age;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.age,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastname": lastname,
      "phone": phone,
      "age": age,
      "id": id,
    };
  }
}
