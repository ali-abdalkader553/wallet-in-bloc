class SignInModel {
  String? _userName;
  String? _password;

  SignInModel({
    required String userName,
    required String password,
  }) {
    _userName = userName;
    _password = password;
  }

  SignInModel.fromJson(dynamic json) {
    _userName = json['userName'];
    _password = json['password'];
  }

  String? get userName => _userName;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['password'] = _password;
    return map;
  }
}
