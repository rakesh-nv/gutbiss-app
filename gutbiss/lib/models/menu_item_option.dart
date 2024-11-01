class MenuItemOption {
  final String name;
  final double price;
  final bool isRequired;
  final bool allowMultiple;
  final List<MenuItemOptionChoice> choices;

  MenuItemOption({
    required this.name,
    required this.price,
    this.isRequired = false,
    this.allowMultiple = false,
    required this.choices,
  });
}

class MenuItemOptionChoice {
  final String name;
  final double additionalPrice;
  bool isSelected;

  MenuItemOptionChoice({
    required this.name,
    this.additionalPrice = 0.0,
    this.isSelected = false,
  });
} 