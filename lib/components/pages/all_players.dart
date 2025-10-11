import 'package:alradi_app/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:alradi_app/services/firebaseApi.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';

class AllPlayers extends StatefulWidget {
  final List<Map<String, dynamic>> playersList;
  const AllPlayers({super.key, required this.playersList});

  @override
  State<AllPlayers> createState() => _AllPlayersState();
}

class _AllPlayersState extends State<AllPlayers> {
  late List<Map<String, dynamic>> playersList;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    playersList = widget.playersList;
  }

  Future<void> _refreshPlayers() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      List<Map<String, dynamic>> updatedPlayers = await FirebaseApi().getPlayers();
      
      setState(() {
        playersList = updatedPlayers;
        _isRefreshing = false;
      });
    } catch (e) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth * 0.04;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: 'لاعبين نادي الرائد'),
        backgroundColor: const Color(0xFFF8F9FA),
        drawer: AppDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenWidth * 0.25,
                margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: screenWidth * 0.03),
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
                    'assets/first_olayr.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.02),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenWidth * 0.03,
                      mainAxisSpacing: screenWidth * 0.03,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: playersList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> currentPlayer = playersList[index];

                      return GestureDetector(
                        onTap: () {
                          print(currentPlayer);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.04),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFE0E0E0),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.04),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                  child: Builder(builder: (context) {
                                    String image = currentPlayer['Image'];
                                    if (image.contains('http')) {
                                      return Image.network(
                                        currentPlayer['Image'],
                                        width: screenWidth * 0.25,
                                        height: screenWidth * 0.25,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            width: screenWidth * 0.25,
                                            height: screenWidth * 0.25,
                                            color: const Color(0xFFF5F5F5),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: const Color.fromARGB(255, 124, 40, 40),
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: screenWidth * 0.25,
                                            height: screenWidth * 0.25,
                                            color: const Color(0xFFF5F5F5),
                                            child: Icon(
                                              Icons.person,
                                              size: screenWidth * 0.1,
                                              color: const Color(0xFF9E9E9E),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Image.asset(
                                        currentPlayer['Image'],
                                        width: screenWidth * 0.25,
                                        height: screenWidth * 0.25,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: screenWidth * 0.25,
                                            height: screenWidth * 0.25,
                                            color: const Color(0xFFF5F5F5),
                                            child: Icon(
                                              Icons.person,
                                              size: screenWidth * 0.1,
                                              color: const Color(0xFF9E9E9E),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }),
                                ),
                                SizedBox(height: screenWidth * 0.02),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                  child: Text(
                                    currentPlayer['Name'],
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF424242),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: screenWidth * 0.01),
                                Text(
                                  currentPlayer['POS'],
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isRefreshing ? null : _refreshPlayers,
          backgroundColor: const Color.fromARGB(255, 124, 40, 40),
          child: _isRefreshing 
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }
}