class Conf {
  String name;
  String id_conf;

  Conf({
    required this.name,
    required this.id_conf,
  });

  factory Conf.fromJson(Map<String, dynamic> json) {
    return Conf(
      name: json['name'] as String,
      id_conf: json['id'].toString(), // Changed to match the new API structure
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id_conf': id_conf,
    };
  }

  @override
  String toString() {
    return 'name: $name, id_conf: $id_conf';
  }
}
