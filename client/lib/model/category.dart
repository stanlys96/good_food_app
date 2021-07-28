class Category {
  int id;
  String title;
  bool isPressed;
  dynamic icon;
  Category({
    required this.id,
    required this.title,
    required this.isPressed,
    required this.icon,
  });
  void setIsPressed(bool val) {
    this.isPressed = val;
  }
}
