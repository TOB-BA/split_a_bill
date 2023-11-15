class PaymentData {
  int userId;
  String firstName;
  String lastName;
  String address;
  int cardNumber;
  double priceToPay;

  PaymentData(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.cardNumber,
      required this.priceToPay});
}
