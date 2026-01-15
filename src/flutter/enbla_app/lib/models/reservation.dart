enum ReservationStatus {
  requested,
  confirmed,
  rejected,
  cancelled,
}

class Reservation {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String customerId;
  final String customerName;
  final String location;
  final DateTime dateTime;
  final int guestCount;
  final ReservationStatus status;

  const Reservation({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.customerId,
    required this.customerName,
    required this.location,
    required this.dateTime,
    required this.guestCount,
      required this.status,
  });
}
