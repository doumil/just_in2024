class Conf {
  String name;
  String date;
  String id_conf;

  Conf({
    required this.name,
    required this.date,
    required this.id_conf,
  });

  factory Conf.fromJson(Map<String, dynamic> json) {
    return Conf(
      name: json['name'] as String,
      date: json['date'] as String,
      id_conf: json['id_conf'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'id_conf': id_conf,
    };
  }

  @override
  String toString() {
    return 'name: $name, date: $date, id_conf: $id_conf';
  }
}
