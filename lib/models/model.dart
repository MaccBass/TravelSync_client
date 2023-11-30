class Login {
  final String accountName;
  final String password;
  final String userId;

  Login(
    this.accountName,
    this.password,
    this.userId,
  );

  Login.fromJson(Map<String, dynamic> json)
      : accountName = json['accountName'],
        password = json['password'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'accountName': accountName,
        'password': password,
        'userId': userId,
      };
}
