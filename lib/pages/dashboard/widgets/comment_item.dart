import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {

  Future<void> _launchWhatsApp() async {
    final String phoneNumber = "+5531982540846";
    final String message = "Felicidades! \n\nParabéns por escolher cuidar de si mesmo(a)! \n\nPara comemorar, a equipe da Clinica Thais Melo, oferece 10% de desconto em seu próximo procedimento. Continue brilhando e inspire todos ao seu redor!";


    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber?text=$message");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding * 0.5,
        vertical: AppDefaults.padding * 0.75,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage("assets/images/illustration/pessoa.jpg"),
              ),
              gapW8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH16,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            _launchWhatsApp();
                          },
                        ),
                      ],
                    ),
                    gapH8,
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
