import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Services/rule_service.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:task_trader/Views/home_screen.dart';

class Rules extends StatefulWidget {
  const Rules({super.key});

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  List<String> rules = []; // Store fetched rules
  final Set<int> selectedIndices = {}; // Store selected rules

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<bool> _isChecked = [];
  List<String> rulesText = [];

  @override
  void initState() {
    super.initState();
    fetchRulesData();
    // Initialize the checkbox states
    _isChecked.addAll(List.generate(rulesText.length, (_) => false));
  }

  Future<void> fetchRulesData() async {
    List<String> fetchedRules = await RulesService().fetchRules();
    if (!mounted) return;
    setState(() {
      rulesText = fetchedRules;
      _isChecked.clear();
      _isChecked.addAll(List.generate(rulesText.length, (_) => false));
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < rulesText.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Changed: Allow the final page to show a dialog regardless of checkbox state
      showDialog(
        context: context,
        builder: (context) => CustomDialog(),
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return rulesText.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.appText(
                "No Rules Found Yet, Add some rules!",
                textAlign: TextAlign.center,
                textColor: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 10,
              ),
              AppButton.appButton(
                "Add",
                onTap: () {
                  pushUntil(context, BottomNavView(index: 0,));
                },
                width: 150,
                height: 50.0,
                textColor: AppTheme.appColor,
                fontWeight: FontWeight.w800,
                backgroundColor: AppTheme.white,
                // onTap: push(context, AddNewRule())
              )
            ],
          ))
        : Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: rulesText.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            rulesText[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CheckboxListTile(
                          value: (index < _isChecked.length)
                              ? _isChecked[index]
                              : false,
                          onChanged: (value) {
                            if (index < _isChecked.length) {
                              setState(() {
                                _isChecked[index] = value ?? false;
                              });
                            }
                          },
                          title: const Text(
                            "I agree to this rule",
                            style: TextStyle(color: Colors.white),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        )

                        // CheckboxListTile(
                        //   value: _isChecked[index],
                        //   onChanged: (value) {
                        //     setState(() {
                        //       _isChecked[index] = value ?? false;
                        //     });
                        //   },
                        //   title: const Text(
                        //     "I agree to this rule",
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        //   controlAffinity: ListTileControlAffinity.leading,
                        // ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      ElevatedButton(
                        onPressed: _goToPreviousPage,
                        child: const Text("Previous"),
                      ),
                       ElevatedButton(
                      onPressed: _goToNextPage, // Changed: Allow navigation regardless of checkbox state
                      child: Text(
                        _currentPage == rulesText.length - 1 ? "Done" : "Next",
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: (_isChecked.isNotEmpty &&
                    //           _isChecked.length > _currentPage &&
                    //           _isChecked[_currentPage])
                    //       ? () {
                    //           if (_currentPage == rulesText.length - 1) {
                    //             // Final action when Done is clicked
                    //             showDialog(
                    //               context: context,
                    //               builder: (context) => CustomDialog(),
                    //             );
                    //           } else {
                    //             _goToNextPage();
                    //           }
                    //         }
                    //       : null,
                    //   child: Text(
                    //     _currentPage == rulesText.length - 1 ? "Done" : "Next",
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
  }
}
