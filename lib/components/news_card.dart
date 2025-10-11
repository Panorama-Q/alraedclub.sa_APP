import 'package:alradi_app/screens/news_full_information.dart';
import 'package:flutter/material.dart';

class MyNewsCard extends StatefulWidget {
  final String title;
  final String category;
  final String img;
  final String content;
  final String time;
  const MyNewsCard({
    super.key,
    required this.title,
    required this.category,
    required this.img,
    required this.content,
    required this.time,
  });

  @override
  State<MyNewsCard> createState() => _MyNewsCardState();
}

class _MyNewsCardState extends State<MyNewsCard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double cardHeight = screenHeight * 0.15;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: cardHeight,
        child: Row(
          children: [
            GestureDetector(
              onTap: _showImageDialog,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  width: cardHeight,
                  color: Colors.grey[200], 
                  child: Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                    width: cardHeight,
                    height: cardHeight,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: cardHeight,
                        height: cardHeight,
                        color: Colors.grey[200],
                        child: Image.asset(
                          'assets/placeholder.PNG',
                          fit: BoxFit.cover,
                          width: cardHeight,
                          height: cardHeight,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: cardHeight,
                        height: cardHeight,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end, 
                  children: [
                    // العنوان
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight, 
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right, 
                        ),
                      ),
                    ),

                    // زر المزيد
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: _navigateToFullNews,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'المزيد',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 155, 47, 40),
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.img,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/placeholder.PNG');
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToFullNews() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FullNews(
        category: widget.category,
        content: widget.content,
        img: widget.img,
        time: widget.time,
        title: widget.title,
      ),
    ));
  }
}