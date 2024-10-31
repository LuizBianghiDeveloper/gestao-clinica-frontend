import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(Radius.circular(AppDefaults.borderRadius)),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              SectionTitle(title: "Agenda"),
              Spacer(),
            ],
          ),
          gapH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.go('/novo-agendamento');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: AppDefaults.padding),
                      child: Column(
                        children: [
                          Icon(Icons.add, size: 40, color: Colors.pink), // Ícone rosa
                          SizedBox(height: 16), // Maior espaçamento vertical
                          Text(
                            'Criar Agendamento',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.go('/agendamento');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: AppDefaults.padding),
                      child: Column(
                        children: [
                          Icon(Icons.calendar_month, size: 40, color: Colors.pink),
                          SizedBox(height: 16),
                          Text(
                            'Ver Agenda',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
