import 'package:flutter/material.dart';
import 'package:task_trader/Resources/screen_sizes.dart';

class TierProgressBar extends StatelessWidget {
  final int userPoints; // Current level value (1 to 5)
  final String? userLevel; 
  final int totalLevels; // Total levels (e.g., 5)

  const TierProgressBar({
    super.key,
    required this.userPoints,
    this.userLevel, required this.totalLevels,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress as a fraction
    double progress = userPoints / totalLevels;

   print("mujy btao user Level : $userLevel");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${getTotalLevelsStart(userLevel!)}', // Dynamically setting total levels
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
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
                      '$userPoints',
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
          '${getTotalLevels(userLevel!)}',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  int getTotalLevels(String userLevel) {
    switch (userLevel) {
      case "Bronze":
        return 5;
      case "Silver":
        return 15;
      case "Gold":
        return 30;
      case "Platinum":
        return 60;
      default:
        return 5; // Default value
    }
  }
  int getTotalLevelsStart(String userLevel) {
    switch (userLevel) {
      case "Bronze":
        return 0;
      case "Silver":
        return 6;
      case "Gold":
        return 16;
      case "Platinum":
        return 31;
      default:
        return 0; // Default value
    }
  }

    int getTotalLevelsForTier(String level) {
  switch (level) {
    case "Bronze":
      return 5;
    case "Silver":
      return 15;
    case "Gold":
      return 30;
    case "Platinum":
      return 50;
    default:
      return 5; // Default to Bronze if no valid level
  }
}
}
