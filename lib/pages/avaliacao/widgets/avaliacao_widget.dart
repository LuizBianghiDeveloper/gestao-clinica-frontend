import 'package:flutter/material.dart';

import '../../../shared/constants/defaults.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class AvaliacaoWidget extends StatefulWidget {
  const AvaliacaoWidget({super.key});

  @override
  State<AvaliacaoWidget> createState() => _AvaliacaoWidgetState();
}

class _AvaliacaoWidgetState extends State<AvaliacaoWidget> {
  int? _selectedScore;

  void _onScoreSelected(int score) {
    setState(() {
      _selectedScore = score;
    });
  }

  // Lista de emojis representando cada nível de satisfação
  final List<String> _emojis = [
    "😡", "😕", "😐", "😀", "😍"
  ];

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Obrigado!'),
          content: const Text('Sua avaliação foi enviada com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Avaliação NPS'),
          const SizedBox(height: 8),
          const Text(
            'Em uma escala de 0 a 10, qual a probabilidade de você recomendar nossos serviços para um amigo?',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => _onScoreSelected(index),
                child: Column(
                  children: [
                    Text(
                      _emojis[index],
                      style: TextStyle(
                        fontSize: 150,
                        color: _selectedScore == index
                            ? Colors.pink
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _selectedScore != null
                  ? () {
                print("Score NPS selecionado: $_selectedScore");
                _showThankYouDialog(); // Chama o popup
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedScore != null
                    ? Colors.pink
                    : Colors.grey,
                disabledBackgroundColor: Colors.grey,
              ),
              child: const Text('Enviar Avaliação'),
            ),
          ),
        ],
      ),
    );
  }
}
