import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../theme/app_colors.dart';

class OverviewTabs extends StatefulWidget {
  const OverviewTabs({
    super.key,
  });

  @override
  State<OverviewTabs> createState() => _OverviewTabsState();
}

class _OverviewTabsState extends State<OverviewTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    initializeDateFormatting('pt_BR', null);
    Intl.defaultLocale = 'pt_BR';
    _tabController = TabController(length: 1, vsync: this)
      ..addListener(() {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH24,
        SizedBox(
          height: 520,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildCalendarWithButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarWithButton() {
    return Column(
      children: [
        Expanded(
          child: TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding * 0.5,
          ),
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {

            },
            child: Text(
              "Criar novo agendamento",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        gapH8,
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding * 0.5,
          ),
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              context.go('/agendamento');
            },
            child: Text(
              "Visualizar agendamentos",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
