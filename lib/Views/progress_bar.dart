import 'package:flutter/material.dart';
import 'package:task_trader/Resources/screen_sizes.dart';

class TierProgressBar extends StatelessWidget {
  final int currentLevel; // Current level value (1 to 5)
  final int totalLevels; // Total levels (e.g., 5)

  const TierProgressBar({
    super.key,
    required this.currentLevel,
    required this.totalLevels,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress as a fraction
    double progress = currentLevel / totalLevels;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '0',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 30,
          width: ScreenSize(context).width * 0.75,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Background Linear Progress Bar
              Container(
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 2),
                  color: Colors.grey[300],
                ),
              ),
              // Progress Linear Indicator
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                ),
              ),
              // Circle to show the current level
              Align(
                alignment: Alignment(progress * 2 - 1, 0),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.teal[900],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$currentLevel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          '5',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
