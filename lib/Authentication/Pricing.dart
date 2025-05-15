// dynamic_pricing_calculator.dart

class DynamicPricingCalculator {
  /// Calculates dynamic price based on booking demand and rating
  ///
  /// [basePrice] - Original price of the vehicle
  /// [carBookingsInPeriod] - Number of bookings for this specific vehicle
  /// [totalBookingsInPeriod] - Total bookings across all vehicles
  /// [avgRating] - Average rating of the vehicle (0-5 scale)
  /// [alpha] - Weight for booking factor (0-0.5)
  /// [beta] - Weight for rating factor (0-0.5)
  ///
  /// Returns the calculated dynamic price
  static double calculateNewPrice({
    required double basePrice,
    required int carBookingsInPeriod,
    required int totalBookingsInPeriod,
    required double avgRating,
    required double alpha,
    required double beta,
  }) {
    // Validate inputs
    assert(alpha >= 0 && alpha <= 0.5, 'Alpha must be between 0 and 0.5');
    assert(beta >= 0 && beta <= 0.5, 'Beta must be between 0 and 0.5');
    assert(totalBookingsInPeriod > 0, 'Total bookings must be greater than 0');
    assert(avgRating >= 0 && avgRating <= 5, 'Rating must be between 0 and 5');

    // Step 1: Calculate Booking Factor
    final bookingFactor = carBookingsInPeriod / totalBookingsInPeriod;

    // Step 2: Calculate Rating Factor (scaled to 5-star system)
    final ratingFactor = avgRating / 5;

    // Step 3: Apply the formula
    return basePrice * (1 + alpha * bookingFactor + beta * ratingFactor);
  }
}