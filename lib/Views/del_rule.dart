import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Services/rule_service.dart';

class DelRules extends StatefulWidget {
  const DelRules({super.key});

  @override
  State<DelRules> createState() => _DelRulesState();
}

class _DelRulesState extends State<DelRules> {
  List<String> rulesText = []; // Store fetched rules


  @override
  void initState() {
    super.initState();
    fetchRulesData();
  }

  Future<void> fetchRulesData() async {
    
    List<String> fetchedRules = await RulesService().fetchRules();
    if (!mounted) return;
    setState(() {
      rulesText = fetchedRules;
    });
  }

  Future<void> _deleteRule(int index) async {
    String ruleToDelete = rulesText[index];
    await RulesService().dellRule(ruleToDelete);
    setState(() {
      rulesText.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {



    return rulesText.isEmpty
        ? Center(
           
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 100, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rulesText.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: ScreenSize(context).width * 0.7,
                 
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.appColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: ScreenSize(context).width * 0.54,
                            child: Text(
                              rulesText[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          right: 1,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteRule(index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}
