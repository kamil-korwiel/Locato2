class Localization {
  int id;
  double latitude;
  double longitude;
  String name;
  String city;
  String street;
  bool isNearBy;
  bool wasNotified;
  bool isSelected ;

  Localization(
      {
        this.id,
        this.latitude,
        this.longitude,
        this.name,
        this.city,
        this.street,
        this.isNearBy,
        this.wasNotified,
        this.isSelected = false
      });
}
