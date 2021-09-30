class DonatedEquipment {
  final String instrumentCode;
  final String instrumentName;
  final int quantity;
  final String donatedDate;
  final String status;
  final String comments;
  final String hospital;
  final String donorOrg;

  DonatedEquipment(this.instrumentCode, this.instrumentName, this.quantity,
      this.donatedDate, this.status, this.comments, this.hospital, this.donorOrg);
}
