class Userscan {
  String firstname;
  String lastname;
  String company;
  String email;
  String phone;
  String adresse;
  String evolution;
  String action;
  String notes;
  String created;
  String updated;
  String ticket;


  Userscan(this.firstname, this.lastname,this.company, this.email,this.phone,this.adresse,this.evolution,this.action,this.notes,this.created,this.updated,this.ticket);
  factory Userscan.fromJson(dynamic json) {
    return Userscan(json['firstname'] as String, json['lastname'] as String,
        json['company'] as String, json['email'] as String,
        json['phone'] as String, json['adresse'] as String,
        json['evolution'] as String, json['action'] as String,
        json['notes'] as String, json['created'] as String,
        json['updated'] as String,
        json['ticket'] as String);
  }
  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'company': company,
      'email': email,
      'phone': phone,
      'adresse': adresse,
      'evolution': evolution,
      'action': action,
      'notes': notes,
      'created':created,
      'updated':updated,
      'ticket':ticket
    };
  }
  @override
  String toString() {
    return 'firstname : $firstname,lastname : $lastname,company : $company,email : $email,phone : $phone,adresse : $adresse,evolution : $evolution,action : $action,notes : $notes,created : $created,updated : $updated,ticket : $ticket';
  }
}
