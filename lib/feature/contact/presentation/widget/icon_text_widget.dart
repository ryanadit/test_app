import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    super.key,
    required this.text,
    this.iconData,
    this.iconColor,
    this.onTap,
  });

  final String? text;
  final IconData? iconData;
  final Color? iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData ?? Icons.email,
            size: 14,
            color: iconColor ?? Colors.amber,
          ),
          const SizedBox(width: 8.0,),
          Flexible(
            child: Text(
              '$text',
              style: const TextStyle(
                  color: Colors.black45, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}