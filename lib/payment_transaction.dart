class PaymentTransaction {
  final String id;
  final int amountPaise;
  final String currency;
  final String method;
  final DateTime createdAt;
  final String status;
  final String? description;

  PaymentTransaction({
    required this.id,
    required this.amountPaise,
    required this.currency,
    required this.method,
    required this.createdAt,
    required this.status,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'amountPaise': amountPaise,
        'currency': currency,
        'method': method,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
        'description': description,
      };

  static PaymentTransaction fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'] as String,
      amountPaise: json['amountPaise'] as int,
      currency: json['currency'] as String,
      method: json['method'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
      description: json['description'] as String?,
    );
  }
}