// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/shadow_card.dart';
import 'package:biscooter/widget/white_card.dart';
import "package:flutter/material.dart";

class MyStatistics extends StatefulWidget {
  const MyStatistics({super.key});

  @override
  State<MyStatistics> createState() => _MyStatisticsState();
}

class _MyStatisticsState extends State<MyStatistics> {
  final double _time = 28;
  double oxygenConsumption(double time) {
    // Calculate the oxygen consumption per minute in ml/kg/min
    double vo2 = 3.5 + 0.2 * 60 + 0.9 * 60 * 22 / 3.6;
    // Multiply by the 60 and the time in minutes to get the total oxygen consumption in ml
    double o2 = vo2 * 60 * time;
    // Divide by 1000 to convert ml to liters
    return o2 / 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("My Statistics"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // the styling
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceTint,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0.03,
              0.2,
            ],
          ),
        ),

        child: Column(
          children: [
            SizedBox(
              height: const MyDimensions().spaceHeight,
            ),

            // the white container
            WhiteCard(
              top: 92,
              child: Column(
                children: [
                  StatCard(
                    icon: Icons.access_time,
                    iconColor: const Color(0xFF5856D6),
                    title: 'Active minutes',
                    value: _time,
                    unit: 'min',
                  ),
                  StatCard(
                    icon: Icons.local_fire_department_outlined,
                    iconColor: const Color(0xFFFF2D55),
                    title: 'Calories',
                    value: (200*_time*0.24*60)/(4.18*1000),
                    unit: 'kcal',
                  ),
                  StatCard(
                    icon: Icons.timeline_rounded,
                    iconColor: const Color(0xFFFF9500),
                    title: 'Distance',
                    value: 22*(50/3)*_time/1000,
                    unit: 'km',
                  ),
                  StatCard(
                    icon: Icons.air,
                    iconColor: const Color.fromARGB(255, 0, 255, 255),
                    title: 'Oxygen Consumption',
                    value: oxygenConsumption(_time),
                    unit: 'ml',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final double value;
  final String unit;
  const StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadowCard(
          radius: 16,
          filter: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            height: 100,
            width: MediaQuery.of(context).size.width - 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 42),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0x4C3D003E),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          value.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Color(0xFF3D003E),
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          unit,
                          style: const TextStyle(
                            color: Color(0xFF3D003E),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
