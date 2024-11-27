import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    super.key,
    required this.name,
    required this.telefone,
  });

  final String name;
  final String telefone;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {

  String formatarTelefone(String telefone) {
    return telefone.replaceAll(RegExp(r'[^0-9]'), '');
  }

  Future<void> _launchWhatsApp() async {
    final String phoneNumber = "+55${formatarTelefone(widget.telefone)}";
    final String message = "🎉 Parabéns! 🎉\n\n"
        "A Clínica Thais Melo Estética Integrativa deseja a você um dia repleto de alegria e realizações! "
        "Que este novo ano de vida traga muitas conquistas e momentos especiais. "
        "Estamos aqui para cuidar de você e ajudar a realçar sua beleza. "
        "Aproveite seu dia! 🎂✨";


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
