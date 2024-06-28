class InUser {
  String in_out;
  String email;
  String created;


  InUser(this.in_out,this.email,this.created);
  factory InUser.fromJson(dynamic json) {
    return InUser(json['in_out'] as String,json['email'] as String,json['created'] as String);
  }
  Map<String, dynamic> toMap() {
    return {
      'in_out': in_out,
      'email':email,
      'created':created,
    };
  }
  @override
  String toString() {
    return 'in_out : $in_out,email :$email,created :$created';
  }
}
