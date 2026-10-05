import '../mixins/gps_location.dart';
import 'user.dart';

abstract class Vehicle with GPSLocation {
  final String id;
  int batteryPercentage;
  bool inUse;
  final double pricePerMinute;

  Vehicle({
    required this.id,
    required this.batteryPercentage,
    this.inUse = false,
    required this.pricePerMinute,
  });

  String batteryStatus() {
    return switch (batteryPercentage) {
      >= 80 => 'High',
      >= 20 => 'Medium',
      _ => 'Critical (Requires charging)',
    };
  }

  double calculateBookingCost(int minutes, {User? user});
}
