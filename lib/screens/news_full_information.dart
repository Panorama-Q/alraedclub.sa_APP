import 'package:flutter/material.dart';

class FullNews extends StatefulWidget {
  final String title;
  final String category;
  final String img;
  final String content;
  final String time;
  const FullNews({
    super.key,
    required this.title,
    required this.category,
    required this.img,
    required this.content,
    required this.time,
  });

  @override
  State<FullNews> createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 124, 40, 40),
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                // الصورة
                Container(
                  height: screenWidth * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.img,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Image.asset(
                              'assets/placeholder.PNG',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              color: const Color.fromARGB(255, 124, 40, 40),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.03),
                
                // العنوان
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.06,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.right,
                ),
                
                SizedBox(height: screenHeight * 0.02),
                
                // المعلومات (التاريخ والفئة)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // الفئة
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 124, 40, 40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      // التاريخ
                      Text(
                        widget.time,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.03),
                
                // المحتوى
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.content,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F9FA),
    );
  }
}