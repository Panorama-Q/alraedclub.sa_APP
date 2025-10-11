import 'package:alradi_app/components/pages/ClubVision.dart';
import 'package:alradi_app/components/pages/SurveyScreen.dart';
import 'package:alradi_app/components/pages/acadmic.dart';
import 'package:alradi_app/components/pages/all_players.dart';
import 'package:alradi_app/components/pages/desires.dart';
import 'package:alradi_app/components/pages/document.dart';
import 'package:alradi_app/components/pages/goalsclub.dart';
import 'package:alradi_app/components/pages/pageemplo.dart';
import 'package:alradi_app/components/pages/pagevisit.dart';
import 'package:alradi_app/components/pages/playdiff.dart';
import 'package:alradi_app/components/pages/problem.dart';
import 'package:alradi_app/components/pages/report.dart';
import 'package:alradi_app/components/pages/store.dart';
import 'package:alradi_app/components/pages/volunteer.dart';
import 'package:alradi_app/screens/about.dart';
import 'package:alradi_app/screens/homepage.dart';
import 'package:alradi_app/screens/news.dart';
import 'package:flutter/material.dart';
import 'package:alradi_app/components/pages/BoardPage.dart';
import 'package:alradi_app/components/pages/StructurePage.dart';
import 'package:expandable/expandable.dart';
import 'package:alradi_app/services/firebaseApi.dart';

class AppDrawer extends StatefulWidget {
  final List<GlobalKey>? keys;
  const AppDrawer({super.key, this.keys});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? _reportYear;
  List<Map<String, dynamic>> footballPlayers = [];
  bool _isLoadingYear = true;

  @override
  void initState() {
    super.initState();
    _loadFootballPlayers();
    _loadReportYear();
  }

  Future<void> _loadReportYear() async {
    final year = await FirebaseApi().getReportYear();
    if (mounted) {
      setState(() {
        _reportYear = year;
        _isLoadingYear = false;
      });
    }
  }

  Future<void> _loadFootballPlayers() async {
    footballPlayers = await FirebaseApi().getPlayers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double iconSize = screenWidth * 0.055;
    final double fontSize = screenWidth * 0.04;

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          backgroundColor: const Color(0xFFFFFFFF),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenWidth * 0.03),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close, size: iconSize),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF9E9E9E),
                              spreadRadius: screenWidth * 0.01,
                              blurRadius: screenWidth * 0.02,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/placeholder.PNG',
                        ),
                      ),
                    ),
                  ],
                ),
                _buildListTile(
                  'الصفحة الرئيسية',
                  Icons.home_filled,
                  const HomePage(),
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildCustomDivider(screenWidth),
                _buildExpandedWidgetWithDivider(
                  'عن نادي الرائد',
                  [
                    _buildListTile(
                      'نبذة تاريخية',
                      Icons.history_edu,
                      const About(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'الهيكل التنظيمي',
                      Icons.account_tree,
                      const StructurePage(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'إتصل بنا',
                      Icons.contact_phone,
                      const BoardPage(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  ],
                  Icons.info_outlined,
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildExpandedWidgetWithDivider(
                  'المركز الاعلامي',
                  [
                    _buildListTile(
                      'الأخبار',
                      Icons.article_outlined,
                      const NewsPage(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'ألبوم الصور',
                      Icons.photo_album_outlined,
                      const Cards(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  ],
                  Icons.ondemand_video_outlined,
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildExpandedWidgetWithDivider(
                  'الرياضات',
                  [
                    _buildListTile(
                      'كرة القدم',
                      Icons.sports_soccer,
                      AllPlayers(playersList: footballPlayers),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'الأكاديمية',
                      Icons.school_outlined,
                      const AcademyPage(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  ],
                  Icons.sports_score_outlined,
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildExpandedWidgetWithDivider(
                  'الإستراتيجية',
                  [
                    _buildListTile(
                      'رؤية النادي ورسالته',
                      Icons.visibility_outlined,
                      const ClubVision(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'الاهداف الإستراتيجية',
                      Icons.flag_outlined,
                      const GoalsClub(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'وثيقة الخطة الإستراتيجية\n(2023-2028)',
                      Icons.description_outlined,
                      const Document(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _isLoadingYear
                        ? _buildYearLoading(screenWidth)
                        : _reportYear != null
                            ? _buildListTile(
                                'التقرير السنوي ($_reportYear)',
                                Icons.assessment_outlined,
                                const Report(),
                                screenWidth: screenWidth,
                                iconSize: iconSize,
                                fontSize: fontSize,
                              )
                            : _buildListTile(
                                'التقرير السنوي',
                                Icons.assessment_outlined,
                                const Report(),
                                screenWidth: screenWidth,
                                iconSize: iconSize,
                                fontSize: fontSize,
                              ),
                  ],
                  Icons.timeline_outlined,
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildExpandedWidgetWithDivider(
                  'الاستطلاعات',
                  [
                    _buildListTile(
                      'استطلاع الجمهور',
                      Icons.people_alt_outlined,
                      SurveyScreen(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'استطلاع الموظفين',
                      Icons.business_center_outlined,
                      pageemplo(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'استطلاع الزوار',
                      Icons.person_search_outlined,
                      pagevisit(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  ],
                  Icons.poll_outlined,
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildListTileWithDivider(
                  'المتجر',
                  Icons.shopping_bag_outlined,
                  const store(),
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildListTileWithDivider(
                  'البلاغات والشكاوي',
                  Icons.report_gmailerrorred_outlined,
                  const Problem(),
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
                _buildExpandedWidgetWithDivider(
                  'المزيد',
                  [
                    _buildListTile(
                      'المتطوعون',
                      Icons.volunteer_activism,
                      const Volunteer(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                    _buildListTile(
                      'الراغبون بالتسجيل',
                      Icons.how_to_reg_outlined,
                      Desires(),
                      screenWidth: screenWidth,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  ],
                  Icons.more_horiz,
                  screenWidth: screenWidth,
                  iconSize: iconSize,
                  fontSize: fontSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYearLoading(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenWidth * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.assessment_outlined,
            color: const Color(0xFF757575),
            size: screenWidth * 0.05,
          ),
          SizedBox(width: screenWidth * 0.01),
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.04,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    String title,
    IconData icon,
    Widget screenName, {
    required double screenWidth,
    required double iconSize,
    required double fontSize,
  }) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screenName),
        (route) => false,
      ),
      child: Container(
        margin: EdgeInsets.only(
          right: screenWidth * 0.04,
          left: screenWidth * 0.02,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenWidth * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF616161), size: iconSize),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  color: const Color(0xFF212121),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTileWithDivider(
    String title,
    IconData icon,
    Widget screenName, {
    required double screenWidth,
    required double iconSize,
    required double fontSize,
  }) {
    return Column(
      children: [
        _buildListTile(
          title,
          icon,
          screenName,
          screenWidth: screenWidth,
          iconSize: iconSize,
          fontSize: fontSize,
        ),
        _buildCustomDivider(screenWidth),
      ],
    );
  }

  Widget _buildExpandedWidgetWithDivider(
    String title,
    List<Widget> children,
    IconData icon, {
    required double screenWidth,
    required double iconSize,
    required double fontSize,
  }) {
    return Column(
      children: [
        _buildExpandedWidget(
          title,
          children,
          icon,
          screenWidth: screenWidth,
          iconSize: iconSize,
          fontSize: fontSize,
        ),
        _buildCustomDivider(screenWidth),
      ],
    );
  }

  Widget _buildExpandedWidget(
    String title,
    List<Widget> children,
    IconData icon, {
    required double screenWidth,
    required double iconSize,
    required double fontSize,
  }) {
    return ExpandablePanel(
      theme: ExpandableThemeData(
        iconPlacement: ExpandablePanelIconPlacement.right,
        iconColor: const Color(0xFF616161),
        iconSize: iconSize,
      ),
      collapsed: const Row(),
      header: Container(
        margin: EdgeInsets.only(
          right: screenWidth * 0.04,
          left: screenWidth * 0.02,
        ),
        height: screenWidth * 0.1,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF616161), size: iconSize),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: const Color(0xFF212121),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
        ),
      ),
      expanded: Padding(
        padding: EdgeInsets.only(
          bottom: screenWidth * 0.01,
          right: screenWidth * 0.04,
          left: screenWidth * 0.02,
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildCustomDivider(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child : const Divider(
        color: Color(0xFFE0E0E0),
        thickness: 0.5,
        height: 1,
      ),
    );
  }
}