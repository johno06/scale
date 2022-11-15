class CheckBoxListTileModel {
  int colorId;
  String title, subtitle;
  bool isCheck;
  CheckBoxListTileModel({required this.colorId, required this.title,  required this.subtitle, required this.isCheck});

  List<dynamic> colors = [
    ['Pfizer', 'Color', '2', 'Red'],
    ['Mic', 'Color', '1', 'Black'],
    ['Style', 'Color', '3', 'Yellow'],
    ['Pre', 'Color', '2', 'Green'],
    ['Prep', 'Color', '4', 'Blue'],
    ['Cologne', 'Color', '1', 'Purple'],
    ['Stay', 'Color', '3', 'Gray'],
    ['Pfizer', 'Color', '1', 'Light Red']
  ];

  static List<CheckBoxListTileModel> getColors() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          colorId: 1,
          title: "Manufacturer: Pfizer",
          subtitle: "Level: 2   Color: Red",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 2,
          title: "Manufacturer: Mic",
          subtitle: "Level: 1   Color: Black",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 3,
          title: "Manufacturer: Style",
          subtitle: "Level: 3   Color: Yellow",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 4,
          title: "Manufacturer: Pre",
          subtitle: "Level: 2   Color: Green",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 5,
          title: "Manufacturer: Prep",
          subtitle: "Level: 4   Color: Blue",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 6,
          title: "Manufacturer: Cologne",
          subtitle: "Level: 1   Color: Purple",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 7,
          title: "Manufacturer: Stay",
          subtitle: "Level: 3   Color: Gray",
          isCheck: false),
      CheckBoxListTileModel(
          colorId: 8,
          title: "Manufacturer: Pfizer",
          subtitle: "Level: 2   Color: Red",
          isCheck: false),
    ];
  }
}