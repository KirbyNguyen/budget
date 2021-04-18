class UserTransaction {
  String accountid;
  String uid;
  String id;
  int type;
  double amount;
  String category;
  String note;
  DateTime date;

  UserTransaction(
      {this.accountid,
      this.uid,
      this.id,
      this.type,
      this.amount,
      this.category,
      this.note,
      this.date});
}
