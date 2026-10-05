import 'vehicle.dart';
import 'user.dart';

class Scooter extends Vehicle {
  final int maxSpeed;

  Scooter({
    required super.id,
    required super.batteryPercentage,
    required super.pricePerMinute,
    this.maxSpeed = 25,
    super.inUse,
  });

  @override
  double calculateBookingCost(int minutes, {User? user}) {
    double total = minutes * pricePerMinute;

    if (user != null && user.isVIP) {
      total *= 0.90; // 10% discount
    }

    return total;
  }
}
