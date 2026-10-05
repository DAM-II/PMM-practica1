import '../exceptions/invalid_amount_exception.dart';

class User {
  final String _id;
  final String _fullName;
  double _balance;
  String email;
  bool isVIP;

  // Named constructor
  User.newUser({
    required String id,
    required String fullName,
    required this.email,
  }) : _id = id,
       _fullName = fullName,
       _balance = 0.0,
       isVIP = false;

  // 2. Full Constructor
  User({
    required String id,
    required String fullName,
    required String email,
    double balance = 0.0,
    this.isVIP = false,
  }) : _id = id,
       _fullName = fullName,
       _balance = balance,
       email = email;

  String get id => _id;
  String get fullName => _fullName;
  double get balance => _balance;

  void topUpBalance(double amount) {
    if (amount <= 0) {
      throw InvalidAmountException(
        'The recharge amount must be greater than zero.',
      );
    }
    _balance += amount;
  }
}
