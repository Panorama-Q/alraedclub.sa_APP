import 'package:alradi_app/components/pages/all_players.dart';
import 'package:alradi_app/services/firebaseApi.dart';
import 'package:flutter/material.dart';

class playersCard extends StatefulWidget {
  const playersCard({super.key});

  @override
  State<playersCard> createState() => _playersCardState();
}

class _playersCardState extends State<playersCard> {
  List<Map<String, dynamic>> playersList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayersFromFirebase();
  }

  Future<void> _loadPlayersFromFirebase() async {
    try {
      List<Map<String, dynamic>> players = await FirebaseApi().getPlayers();
      
      setState(() {
        playersList = players;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading players: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              height: 250, 
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : playersList.isEmpty
                      ? Center(child: Text('لا يوجد لاعبين'))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: playersList.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> currentPlayer = playersList[index];
                            return GestureDetector(
                              onTap: () {
                                print(currentPlayer);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4, 
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Builder(builder: (context) {
                                            String image = currentPlayer['Image'];
                                            if (image.contains('http')) {
                                              return Image.network(
                                                currentPlayer['Image'],
                                                width: MediaQuery.of(context).size.width * 0.3, 
                                                height: MediaQuery.of(context).size.width * 0.3, 
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Container(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    height: MediaQuery.of(context).size.width * 0.35,
                                                    color: Colors.grey[200],
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    height: MediaQuery.of(context).size.width * 0.35,
                                                    color: Colors.grey[300],
                                                    child: Icon(Icons.person, size: 50), 
                                                  );
                                                },
                                              );
                                            } else {
                                              return Image.asset(
                                                currentPlayer['Image'],
                                                height: MediaQuery.of(context).size.width * 0.45, 
                                                width: MediaQuery.of(context).size.width * 0.45,  
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    height: MediaQuery.of(context).size.width * 0.45,
                                                    width: MediaQuery.of(context).size.width * 0.45,
                                                    color: Colors.grey[300],
                                                    child: Icon(Icons.person, size: 60), 
                                                  );
                                                },
                                              );
                                            }
                                          }),
                                        ),
                                        SizedBox(height: 10), 
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 6),
                                          child: Text(
                                            currentPlayer['Name'],
                                            style: TextStyle(
                                              fontSize: 18, 
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          currentPlayer['POS'],
                                          style: TextStyle(
                                            fontSize: 16, 
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[700],
                                          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                TextButton(
                  onPressed: _isLoading || playersList.isEmpty
                      ? null 
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllPlayers(playersList: playersList),
                            ),
                          );
                        },
                  child: Text(
                    'عرض المزيد',
                    style: TextStyle(
                      color: (_isLoading || playersList.isEmpty)
                          ? Colors.grey 
                          : Color.fromARGB(255, 155, 47, 40),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}