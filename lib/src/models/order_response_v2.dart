class OrderResponseV2 {
  final String? orderId;

  OrderResponseV2({
    this.orderId,
  });

  factory OrderResponseV2.fromJson(Map<String, dynamic> json) {
    return OrderResponseV2(
      orderId: json["orderId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
      };
}
