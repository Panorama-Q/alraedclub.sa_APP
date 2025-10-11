import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  const Cards({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth * 0.04;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'ألبوم الصور'),
        drawer: AppDrawer(),
        backgroundColor: const Color(0xFFF8F9FA),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenWidth * 0.03),
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFE0E0E0),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                child: Image.asset(
                  'assets/diff.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: screenWidth * 0.25,
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(horizontalPadding),
                child: GridView.count(
                  crossAxisCount: screenWidth < 600 ? 2 : 3,
                  mainAxisSpacing: screenWidth * 0.025,
                  crossAxisSpacing: screenWidth * 0.025,
                  childAspectRatio: 0.7,
                  children: const [
                   CardWidget(
                      name: 'الأمير محمد بن سلمان',
                      imagePath: 'assets/alamir.jpg',
                    ),
                    CardWidget(
                      name: '93 هي لنا دار',
                      imagePath: 'assets/natorla.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد شيك كافيه',
                      imagePath: 'assets/onen.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد @Azom_sa',
                      imagePath: 'assets/azum.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد @hilwawatersa',
                      imagePath: 'assets/halui.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد @AMClksa',
                      imagePath: 'assets/car.jpg',
                    ),
                    CardWidget(
                      name: ' 🤝 | شراكة نفتخر بها #الرائد @Alqaidsa',
                      imagePath: 'assets/gaidd.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد @TahalufCapital',
                      imagePath: 'assets/thalaf.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد @shwearmakingarb',
                      imagePath: 'assets/shaorma.jpg',
                    ),
                    CardWidget(
                      name: '🤝 | شراكة نفتخر بها #الرائد @BCareKSA',
                      imagePath: 'assets/becar.jpg',
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
}

class CardWidget extends StatelessWidget {
  final String name;
  final String imagePath;

  const CardWidget({
    Key? key,
    required this.name,
    required this.imagePath,
  });

  String _simplifyText(String text) {
    return text
        .replaceAll('🤝 | شراكة نفتخر بها #الرائد ', '')
        .replaceAll('@', '');
  }

  String _getCompanyName(String text) {
    if (text.contains('@')) {
      final match = RegExp(r'@(\w+)').firstMatch(text);
      if (match != null) {
        return match.group(1)!;
      }
    }
    return _simplifyText(text);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    final companyName = _getCompanyName(name);
    final isPartnership = name.contains('شراكة');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenWidth * 0.48,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.03),
                topRight: Radius.circular(screenWidth * 0.03),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  if (isPartnership)
                    Positioned(
                      top: screenWidth * 0.01,
                      right: screenWidth * 0.01,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.015,
                          vertical: screenWidth * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 124, 40, 40),
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        ),
                        child: Text(
                          'شراكة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.022,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.015,
              vertical: screenWidth * 0.01,
            ),
            decoration: BoxDecoration(
              color: isPartnership 
                  ? const Color(0xFFFDF2F2)
                  : Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(screenWidth * 0.03),
                bottomRight: Radius.circular(screenWidth * 0.03),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isPartnership)
                  Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.005),
                    child: Text(
                      'شراكة نفتخر بها',
                      style: TextStyle(
                        fontSize: screenWidth * 0.022,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF757575),
                      ),
                    ),
                  ),
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.028,
                    fontWeight: FontWeight.w600,
                    color: isPartnership 
                        ? const Color.fromARGB(255, 124, 40, 40)
                        : const Color(0xFF424242),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}