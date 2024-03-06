import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/category/category.dart';

class CategoryChipWidget extends StatefulWidget {
  const CategoryChipWidget({super.key, required this.category});

  final Category category;

  @override
  State<StatefulWidget> createState() {
    return _CategoryChipWidget();
  }
}

class _CategoryChipWidget extends State<CategoryChipWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.category.name),
      avatar:
          SvgPicture.asset(widget.category.icon, semanticsLabel: 'Car Logo'),
      selected: isSelected,
      showCheckmark: false,
      selectedColor: const Color(0xffcccccc),
      onSelected: (newState) {
        setState(() {
          isSelected = newState;
        });
      },
    );
  }
}
