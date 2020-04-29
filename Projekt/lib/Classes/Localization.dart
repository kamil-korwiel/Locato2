class Localization {
  int id;
  double latitude;
  double longitude;
  String name;
  String city;
  String street;
  bool isSelected = false;

  Localization(
      {this.id,
      this.latitude,
      this.longitude,
      this.name,
      this.city,
      this.street,
      this.isSelected,});
}
