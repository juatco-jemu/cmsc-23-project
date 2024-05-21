import 'dart:convert';

class Account {
  String? firstName;
  String? lastName;
  String? email;

  Account({
    required this.firstName,
    required this.lastName,
    required this.email
  });

  // Factory constructor to instantiate object from json format
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email']
    );
  }

  static List<Account> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Account>((dynamic d) => Account.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Account account) {
    return {
      'firstName': account.firstName,
      'lastName': account.lastName,
      'email': account.email
    };
  }
}
