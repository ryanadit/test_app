import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_project/core/misc/app_color.dart';
import 'package:test_app_project/feature/contact/data/models/contact_model.dart';
import 'package:test_app_project/feature/contact/presentation/widget/icon_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailContactPage extends StatelessWidget {
  const DetailContactPage({
    super.key,
    required this.contact, 
  });

  final ContactModel contact;

  void actionEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '${contact.email}',
    );
    if (! await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch $emailLaunchUri');
    }
  }

  void actionCaller() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '${contact.numberPhone}',
    );
    if (! await launchUrl(phoneLaunchUri)) {
      throw Exception('Could not launch $phoneLaunchUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    const spaceWidget = SizedBox(height: 8.0);
    const spaceWidgetLarge = SizedBox(
      height: 15.0,
    );
    const spaceWidgetMedium = SizedBox(
      width: 12.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Contact',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 18.0
              ),
            ),
            spaceWidgetLarge,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.textHeaderDetail,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${contact.avatar}',
                    width: 72,
                    height: 72,
                    progressIndicatorBuilder: (context, url, progress) => const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 12,
                      ),
                    ),
                  ),
                  spaceWidgetMedium,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${contact.name}',
                          style: const TextStyle(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0
                          ),
                        ),
                        spaceWidgetLarge,
                        IconTextWidget(
                          text: '${contact.email}',
                          iconData: Icons.email,
                          iconColor: Colors.orange.shade400,
                          onTap: actionEmail,
                        ),
                        spaceWidgetLarge,
                        IconTextWidget(
                          text: '${contact.numberPhone}',
                          iconData: Icons.phone,
                          iconColor: Colors.green.shade300,
                          onTap: actionCaller,
                        ),
                        spaceWidgetLarge,
                        IconTextWidget(
                          text: '${contact.gender}',
                          iconData: Icons.person,
                          iconColor: Colors.blueGrey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            spaceWidget,
            Divider(
                thickness: 0.5, 
                color: Colors.grey.shade300
            ),
            spaceWidget,
          ],
        ),
      ),
    );
  }
}