class UserTransaction {
  String accountid;
  String uid;
  String id;
  String categoryid;
  int type;
  double amount;
  String note;
  DateTime date;

  UserTransaction(
      {this.accountid,
      this.uid,
      this.id,
      this.categoryid,
      this.type,
      this.amount,
      this.note,
      this.date});
}
