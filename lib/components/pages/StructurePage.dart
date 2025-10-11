import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:alradi_app/components/drawer.dart';

class StructurePage extends StatelessWidget {
  const StructurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'الهيكل التنظيمي'),
        drawer: AppDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE0E0E0),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFEEEEEE),
                                width: 1,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_tree_rounded,
                                color: Color.fromARGB(255, 124, 40, 40),
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'الهيكل التنظيمي الإداري',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 124, 40, 40),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE0E0E0),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: const Color(0xFFF0F0F0),
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/stru.jpg',
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}