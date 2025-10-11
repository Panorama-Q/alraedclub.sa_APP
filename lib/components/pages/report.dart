// ignore_for_file: deprecated_member_use

import 'package:alradi_app/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _reportUrl = '';
  String _reportYear = '';
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadReportData();
  }

  Future<void> _loadReportData() async {
    try {
      final reportDoc = await FirebaseFirestore.instance
          .collection('annual_report')
          .doc('tpoKaF6XT78Gvr4dgm69')
          .get();

      if (reportDoc.exists) {
        final data = reportDoc.data() as Map<String, dynamic>;
        setState(() {
          _reportUrl = data['url'] ?? '';
          _reportYear = data['year'] ?? '';
          _isLoading = false;
        });
        
        print('✅ تم تحميل بيانات التقرير: $_reportYear');
        print('🔗 الرابط: $_reportUrl');
      } else {
        // لو مفيش بيانات في الفايربيز
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        print('❌ لا توجد بيانات للتقرير في الفايربيز');
      }
    } catch (e) {
      print('❌ خطأ في تحميل بيانات التقرير: $e');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> openBrowser() async {
    if (_reportUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد رابط للتقرير حالياً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final Uri url = Uri.parse(_reportUrl);
    
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر فتح التقرير. يرجى المحاولة لاحقاً'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('❌ خطأ في فتح الرابط: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('حدث خطأ أثناء فتح التقرير'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'إعادة المحاولة',
            onPressed: openBrowser,
          ),
        ),
      );
    }
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: const Color(0xFF7C2828)),
          const SizedBox(height: 16),
          const Text(
            'جاري تحميل بيانات التقرير...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'لا توجد بيانات للتقرير حالياً',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'سيتم إضافة التقرير قريباً',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadReportData,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C2828),
              foregroundColor: Colors.white,
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
            textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التقرير السنوي'),
          actions: [
            ClipOval(
              child: Image.asset('assets/logo.png'),
            ),
          ],
          backgroundColor: const Color(0xFF7C2828),
          centerTitle: true,
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? _buildLoading()
            : _hasError || _reportUrl.isEmpty
                ? _buildError()
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF7C2828).withOpacity(0.1),
                          const Color(0xFF7C2828).withOpacity(0.05),
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          margin: const EdgeInsets.only(top: 40, bottom: 20),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7C2828).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7C2828).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF7C2828),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.assignment,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // عنوان التقرير
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            'التقرير السنوي لنادي الرائد',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C2828),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // سنة التقرير (تأتي من الفايربيز فقط)
                        if (_reportYear.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C2828).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _reportYear,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF7C2828),
                              ),
                            ),
                          ),
                        
                        const SizedBox(height: 40),
                        
                        // زر المعاينة (يظهر فقط لو في رابط)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7C2828), Color(0xFF9A3A3A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C2828).withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: openBrowser,
                              borderRadius: BorderRadius.circular(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'معاينة التقرير',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}