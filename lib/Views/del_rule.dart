import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/custom_dialogue.dart';
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
        : Column(
          children: [
            Text("Your Rules",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: rulesText.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: ScreenSize(context).width * 0.7,
                     
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? AppTheme.rulesColor1 : AppTheme.rulesColor2,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: ScreenSize(context).width * 0.54,
                                child: Text(
                                  rulesText[index],
                                  style: TextStyle(
                                    color: AppTheme.rulesTextColor,
                                    fontSize: 20,
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
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      title: "Delete Rule?",
                                       onYesTap: () {
                                        _deleteRule(index);
                                        Navigator.pop(context);
                                      },
                                      onNoTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        );
  }
}
