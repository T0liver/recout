class WorkOut {
  String wid;
  String name;
  DateTime date;
  double duration;
  String durationUnit;
  String location;
  String icon;

  WorkOut({
    required this.wid,
    required this.name,
    required this.date,
    required this.duration,
    required this.durationUnit,
    this.location ='',
    this.icon = 'assets/graphics/icons/icons8-strong-arm-128.png',
  });
}