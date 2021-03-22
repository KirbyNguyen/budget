class UserTransaction {
  String accountid;
  String uid;
  String id;
  double amount;
  String category;
  DateTime date;

  UserTransaction(
      {this.accountid,
      this.uid,
      this.id,
      this.amount,
      this.category,
      this.date});
}
