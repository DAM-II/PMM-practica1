import 'vehicle.dart';
import 'user.dart';

class Car extends Vehicle {
  final int seats;
  final bool requiresLicense;
  static const double ecoFilterFee = 2.0;

  Car({
    required super.id,
    required super.batteryPercentage,
    required super.pricePerMinute,
    required this.seats,
    this.requiresLicense = true,
    super.inUse,
  });

  @override
  double calculateBookingCost(int minutes, {User? user}) {
    return (minutes * pricePerMinute) + ecoFilterFee;
  }
}
