import '../models/user.dart';
import '../models/vehicle.dart';
import '../models/scooter.dart';
import '../models/car.dart';
import '../exceptions/invalid_amount_exception.dart';

void main() {
  // 1. FLEET INITIALIZATION (flota)
  print('--- 1. INITIALIZING FLEET (MALLORCA & MANACOR) ---');
  final List<Vehicle> fleet = [
    // Scooter 1: High battery, available
    Scooter(
      id: 'SCOOT-01',
      batteryPercentage: 95,
      pricePerMinute: 0.20,
      maxSpeed: 25,
      inUse: false,
    )..updateLocation(39.5696, 3.2096), // Plaça de sa Bassa, Manacor
    // Scooter 2: Medium battery, currently in use
    Scooter(
      id: 'SCOOT-02',
      batteryPercentage: 55,
      pricePerMinute: 0.20,
      maxSpeed: 25,
      inUse: true,
    )..updateLocation(39.5739, 3.2045), // Estació de Manacor
    // Scooter 3: Critical battery, available
    Scooter(
      id: 'SCOOT-03',
      batteryPercentage: 14,
      pricePerMinute: 0.18,
      maxSpeed: 20,
      inUse: false,
    )..updateLocation(39.5681, 3.2140), // Plaça Ramon Llull, Manacor
    // Car 1: High battery, available
    Car(
      id: 'CAR-01',
      batteryPercentage: 82,
      pricePerMinute: 0.45,
      seats: 5,
      inUse: false,
    )..updateLocation(39.5517, 2.7388), // Aeroport de Palma de Mallorca

    Car(
      id: 'CAR-02',
      batteryPercentage: 10,
      pricePerMinute: 0.50,
      seats: 4,
      inUse: true,
    )..updateLocation(39.5755, 2.6541), // Plaça d'Espanya, Palma
  ];

  print('Fleet created with ${fleet.length} vehicles.');

  // 2. SEARCH & FILTER (Functional Programming)
  print('\n--- 2. FUNCTIONAL SEARCH & FILTERS ---');

  // A. Find vehicle with highest battery using reduce()
  final highestBatteryVehicle = fleet.reduce(
    (current, next) =>
        current.batteryPercentage > next.batteryPercentage ? current : next,
  );
  print(
    'Vehicle with highest battery: '
    '${highestBatteryVehicle.id} '
    '(${highestBatteryVehicle.batteryPercentage}%, status: ${highestBatteryVehicle.batteryStatus()})',
  );

  // B. Filtering (where) + Transforming (map) + Printing (forEach)
  print('\nAvailable vehicles ready to rent (Battery > 20% and not in use):');
  fleet
      .where((vehicle) => vehicle.batteryPercentage > 20 && !vehicle.inUse)
      .map(
        (v) =>
            ' - ID: ${v.id} | Type: ${v.runtimeType} | Battery: ${v.batteryPercentage}%',
      )
      .forEach(print);

  // 3. BOOKING SIMULATION & RECORD DESTRUCTURING
  print('\n--- 3. BOOKING SIMULATION & RECORD DESTRUCTURING ---');

  final testUser = User(
    id: 'USR-101',
    fullName: 'Jordi Pujadas',
    email: 'jordi.pujadas@example.com',
    balance: 25.0,
    isVIP: true,
  );

  // Pick the first available scooter from the fleet
  final selectedScooter =
      fleet.firstWhere((v) => v is Scooter && !v.inUse) as Scooter;

  const int tripDuration = 15; // 15 minutes
  selectedScooter.inUse = true;

  final cost = selectedScooter.calculateBookingCost(
    tripDuration,
    user: testUser,
  );
  print('User: ${testUser.fullName} (VIP: ${testUser.isVIP})');
  print('Booked: ${selectedScooter.id} for $tripDuration minutes.');
  print('Calculated Cost: ${cost.toStringAsFixed(2)}€');

  // Simulated 15-minute ride: Plaça de sa Bassa -> Rafa Nadal Academy (Manacor)
  selectedScooter.updateLocation(39.5802, 3.2185);

  // Record Destructuring: unpack (double lat, double lng)
  var (lat, lng) = selectedScooter.getCoordinates();
  print('Updated coordinates after trip: Latitude = $lat, Longitude = $lng');

  // 4. ERROR HANDLING (Validation & Try-Catch)
  print('\n--- 4. ERROR HANDLING ---');

  print('Current balance for ${testUser.fullName}: ${testUser.balance}€');
  print('Attempting to recharge invalid balance of -10.0€...');

  try {
    testUser.topUpBalance(-10.0);
    print('Recharge successful.');
  } on InvalidAmountException catch (e) {
    print('Caught custom domain error: $e');
  } catch (e) {
    print('Unexpected generic error: $e');
  }

  print('Balance after failed recharge attempt: ${testUser.balance}€');
  print('Program finished cleanly without crashing.');
}
