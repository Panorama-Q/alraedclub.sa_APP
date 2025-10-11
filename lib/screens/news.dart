import 'package:alradi_app/components/drawer.dart';
import 'package:alradi_app/components/news_card.dart';
import 'package:alradi_app/screens/custom_app_bar.dart';
import 'package:alradi_app/services/firebaseApi.dart';
import 'package:alradi_app/services/function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var temp;
  String loaded = '0';

  Future getdata() {
    print('loaded');
    temp += temp;
    return (temp);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: CustomAppBar(title: 'الأخبار'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: temp is List<DocumentSnapshot>
                  ? getdata()
                  : FirebaseApi().getData('news'),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Center(
                    child: RefreshProgressIndicator(),
                  );
                }

                var news = snapshot.data as List<DocumentSnapshot>;
                temp = news;

                sortList(temp);

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (context, index) {
                          var item =
                              news[index].data() as Map<dynamic, dynamic>;
                          Map<String, dynamic> map = Map.from(item);
                          DateTime dateTime = map['time'].toDate();

                          String year = dateTime.year.toString();
                          String month = dateTime.month.toString();
                          String day = dateTime.day.toString();
                          String dateTime0 = '$year-$month-$day';
                          // print(map['img']);
                          return MyNewsCard(
                            title: map['title'] ?? "",
                            category: map['category'] ?? "",
                            img: map['img'] ?? "",
                            content: map['content'] ?? "",
                            time: dateTime0,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
