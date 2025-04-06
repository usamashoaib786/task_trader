import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/custom_dialogue.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Services/rule_service.dart';

class DelRules extends StatefulWidget {
  const DelRules({super.key});

  @override
  State<DelRules> createState() => _DelRulesState();
}

class _DelRulesState extends State<DelRules> with TickerProviderStateMixin {
  List<String> rulesText = [];
  bool isLoading = true;
  late AnimationController _fetchAnimationController;
  List<AnimationController> _itemControllers = [];

  @override
  void initState() {
    super.initState();

    _fetchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    fetchRulesData();
  }

  Future<void> fetchRulesData() async {
    List<String> fetchedRules = await RulesService().fetchRules();
    if (!mounted) return;

    // Initialize animation controllers for each item
    for (int i = 0; i < fetchedRules.length; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 300 + (i * 100)),
        vsync: this,
      );
      _itemControllers.add(controller);
    }

    setState(() {
      rulesText = fetchedRules;
      isLoading = false;
    });

    // Start animations
    _fetchAnimationController.forward();
    for (var controller in _itemControllers) {
      controller.forward();
    }
  }

  Future<void> _deleteRule(int index) async {
    final controller = _itemControllers[index];

    // Animate the item down before removing
    await controller.reverse();

    // Remove from Firebase first
    await RulesService().dellRule(rulesText[index]);

    // Then remove from local state
    setState(() {
      rulesText.removeAt(index);
      _itemControllers.removeAt(index);
    });

    // Dispose the controller
    controller.dispose();
  }

  Future<void> _editRule(int index) async {
    TextEditingController textController =
        TextEditingController(text: rulesText[index]);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text("Edit Rule", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: textController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter new rule",
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () async {
              await RulesService()
                  .updateRuleAtIndex(index, textController.text);
              setState(() {
                rulesText[index] = textController.text;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fetchAnimationController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingIcon: Images.backIconBlack,
        title: "Your Rules",
        fontsize: 25,
        fontWeight: FontWeight.w800,
        color: AppTheme.white,
      ),
      body: isLoading
          ? Center(
              child: ScaleTransition(
                scale: _fetchAnimationController,
                child: const CircularProgressIndicator(),
              ),
            )
          : rulesText.isEmpty
              ? Center(
                  child: FadeTransition(
                    opacity: _fetchAnimationController,
                    child: const Text("No Rules Found",
                        style: TextStyle(color: Colors.white70, fontSize: 18)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: rulesText.length,
                    itemBuilder: (context, index) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1.0), // From bottom
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _itemControllers[index],
                          curve: Curves.easeOutBack,
                        )),
                        child: FadeTransition(
                          opacity: _itemControllers[index],
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 83, 54, 96),
                                  Color.fromARGB(255, 148, 120, 161),
                                ],
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      rulesText[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Column(
                                    children: [
                                      _buildActionButton(
                                        onTap: () => _editRule(index),
                                        icon: Icons.edit,
                                      ),
                                      const SizedBox(height: 20),
                                      _buildActionButton(
                                        icon: Icons.delete_forever,
                                        iconColor: Colors.red,
                                        onTap: () {
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildActionButton({
    required Function()? onTap,
    required IconData icon,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: AppTheme.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
