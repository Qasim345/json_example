class Info {
  String name;
  int age;
  Info({
    required this.name,
    required this.age,
  });

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }
}
