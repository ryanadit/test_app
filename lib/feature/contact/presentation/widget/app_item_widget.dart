import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemAppWithImageWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final Color? colorBg;
  final String urlImg;
  final String? phoneNumber;
  
  const ItemAppWithImageWidget({
    super.key,
    this.title,
    this.onTap,
    this.colorBg,
    required this.urlImg,
    this.phoneNumber
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10
      ),
      decoration: BoxDecoration(
        color: colorBg ?? Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.blueGrey.shade100
          )
        )
      ),
      child: ListTile(
          onTap: onTap,
          isThreeLine: true,
          leading: CachedNetworkImage(
            imageUrl: urlImg,
            width: 36,
            height: 36,
            progressIndicatorBuilder: (context, url, progress) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 12,
              ),
            ),
          ),
          title: Text(
            '$title',
            style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '$phoneNumber',
            style: TextStyle(
              color: Colors.grey.shade600, fontWeight: FontWeight.w400),
          )
        ),
    );
  }
}