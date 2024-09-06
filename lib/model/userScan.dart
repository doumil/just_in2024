class Userscan24{
  String nom;
  String prenom;
  String email;
  String societe;
  String tel;
  String profession;
  String hashedOrderId;
  String ticket;

  Userscan24({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.societe,
    required this.tel,
    required this.profession,
    required this.hashedOrderId,
    required this.ticket,
  });

  factory Userscan24.fromJson(Map<String, dynamic> json) {
    return Userscan24(
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      societe: json['societe'] ?? '',
      tel: json['tel'] ?? '',
      profession: json['profession'] ?? '',
      hashedOrderId: json['hashed_order_id'] ?? '',
      ticket: json['ticket'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'societe': societe,
      'tel': tel,
      'profession': profession,
      'hashed_order_id': hashedOrderId,
      'ticket': ticket,
    };
  }

  @override
  String toString() {
    return 'nom: $nom, prenom: $prenom, email: $email, societe: $societe, tel: $tel, profession: $profession, hashed_order_id: $hashedOrderId, ticket: $ticket';
  }
}
