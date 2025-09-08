/// Utility functions for number formatting and manipulation
///
/// This module provides functions for handling number formatting requirements
/// specific to the Hyperliquid API, including automatic trailing zero removal.
class NumberUtils {
  /// Remove trailing zeros from numeric strings and numbers
  ///
  /// The Hyperliquid API requires that price and size fields do not contain
  /// trailing zeros. This function handles the conversion automatically.
  ///
  /// Examples:
  /// - "12345.0" -> "12345"
  /// - "0.123450" -> "0.12345"
  /// - 12345.0 -> "12345"
  /// - 0.123450 -> "0.12345"
  static String removeTrailingZeros(dynamic value) {
    if (value == null) return '0';

    // Convert to string if it's a number
    String strValue;
    if (value is num) {
      strValue = value.toString();
    } else if (value is String) {
      strValue = value;
    } else {
      throw ArgumentError('Value must be a number or string');
    }

    // Handle scientific notation
    if (strValue.contains('e') || strValue.contains('E')) {
      final numValue = double.parse(strValue);
      strValue = numValue.toString();
    }

    // Remove trailing zeros after decimal point
    if (strValue.contains('.')) {
      strValue = strValue.replaceAll(RegExp(r'0+$'), ''); // Remove trailing zeros
      strValue = strValue.replaceAll(RegExp(r'\.$'), ''); // Remove trailing decimal point
    }

    // Handle edge case where result is empty (e.g., "0.000" -> "")
    if (strValue.isEmpty) {
      return '0';
    }

    return strValue;
  }

  /// Format a number for Hyperliquid API (removes trailing zeros)
  ///
  /// [value] - The numeric value to format
  /// Returns a string representation without trailing zeros
  static String formatForAPI(num value) {
    return removeTrailingZeros(value);
  }

  /// Normalize an order object to remove trailing zeros from price and size fields
  ///
  /// [order] - The order object to normalize
  /// Returns a new order object with normalized numeric fields
  static Map<String, dynamic> normalizeOrder(Map<String, dynamic> order) {
    final normalized = Map<String, dynamic>.from(order);

    // Normalize price field
    if (normalized.containsKey('limit_px')) {
      normalized['limit_px'] = removeTrailingZeros(normalized['limit_px']);
    }

    // Normalize size field
    if (normalized.containsKey('sz')) {
      normalized['sz'] = removeTrailingZeros(normalized['sz']);
    }

    // Normalize trigger price for trigger orders
    if (normalized.containsKey('order_type') &&
        normalized['order_type'] is Map<String, dynamic> &&
        (normalized['order_type'] as Map<String, dynamic>).containsKey('trigger')) {
      final orderType = normalized['order_type'] as Map<String, dynamic>;
      final trigger = orderType['trigger'];
      if (trigger is Map<String, dynamic> && trigger.containsKey('triggerPx')) {
        trigger['triggerPx'] = removeTrailingZeros(trigger['triggerPx']);
      }
    }

    // Recursively normalize nested orders (for batch orders)
    if (normalized.containsKey('orders') && normalized['orders'] is List) {
      final orders = normalized['orders'] as List;
      normalized['orders'] = orders.map((order) {
        if (order is Map<String, dynamic>) {
          return normalizeOrder(order);
        }
        return order;
      }).toList();
    }

    return normalized;
  }

  /// Normalize a list of orders to remove trailing zeros
  ///
  /// [orders] - List of order objects to normalize
  /// Returns a new list with normalized orders
  static List<Map<String, dynamic>> normalizeOrders(List<Map<String, dynamic>> orders) {
    return orders.map(normalizeOrder).toList();
  }

  /// Check if a string represents a valid numeric value for the API
  ///
  /// [value] - The string to validate
  /// Returns true if the value is valid for API submission
  static bool isValidNumericString(String value) {
    try {
      double.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Safely parse a numeric value, handling various input types
  ///
  /// [value] - The value to parse
  /// Returns the parsed number or throws an error if invalid
  static num parseNumeric(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.parse(value);
    } else {
      throw ArgumentError('Cannot parse value as number: $value');
    }
  }

  /// Format a price with appropriate decimal places based on asset type
  ///
  /// [price] - The price to format
  /// [isSpot] - Whether this is a spot market (affects decimal precision)
  /// Returns a formatted price string
  static String formatPrice(num price, {bool isSpot = false}) {
    if (isSpot) {
      // Spot markets typically use more decimal places
      return price.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    } else {
      // Perpetuals use fewer decimal places
      final priceStr = price.toString();
      final parts = priceStr.split('.');
      if (parts.length == 2) {
        final decimalPart = parts[1];
        // Keep up to 5 decimal places for perpetuals, but remove trailing zeros
        final maxDecimals = decimalPart.length > 5 ? 5 : decimalPart.length;
        return price.toStringAsFixed(maxDecimals).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return priceStr;
    }
  }

  /// Format a size with appropriate decimal places
  ///
  /// [size] - The size to format
  /// Returns a formatted size string
  static String formatSize(num size) {
    // Remove unnecessary decimal places while preserving precision
    final sizeStr = size.toString();
    if (sizeStr.contains('.')) {
      return sizeStr.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return sizeStr;
  }
}
