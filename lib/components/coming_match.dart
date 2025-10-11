import 'dart:async';

import 'package:alradi_app/components/MatchesPage.dart';
import 'package:alradi_app/services/firebaseApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpComingMatch extends StatefulWidget {
  final VoidCallback? onViewAllMatches;

  const UpComingMatch({super.key, this.onViewAllMatches});

  @override
  State<UpComingMatch> createState() => _UpComingMatchState();
}

class _UpComingMatchState extends State<UpComingMatch> {
  Map<String, dynamic>? _currentMatchData;
  Duration? _timeRemaining;
  Timer? _timer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNextMatch();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadNextMatch() async {
    try {
      final match = await FirebaseApi().getNextMatch();

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (match != null) {
            _currentMatchData = match.data() as Map<String, dynamic>;
            _calculateTimeRemaining();
          } else {
            _currentMatchData = null;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _currentMatchData = null;
        });
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _currentMatchData != null) {
        _calculateTimeRemaining();
      }
    });
  }

  void _calculateTimeRemaining() {
    if (!mounted || _currentMatchData == null) return;

    try {
      final matchTime = (_currentMatchData!['time'] as Timestamp).toDate();
      final now = DateTime.now();
      final difference = matchTime.difference(now);

      if (difference.isNegative) {
        if (mounted) {
          _loadNextMatch();
        }
      } else {
        if (mounted) {
          setState(() {
            _timeRemaining = difference;
          });
        }
      }
    } catch (e) {
      print('Error calculating time: $e');
    }
  }

  String _formatCountdown() {
    if (_timeRemaining == null) return '--:--:--';

    final days = _timeRemaining!.inDays;
    final hours = _timeRemaining!.inHours.remainder(24);
    final minutes = _timeRemaining!.inMinutes.remainder(60);
    final seconds = _timeRemaining!.inSeconds.remainder(60);

    if (days > 0) {
      return '${days.toString().padLeft(2, '0')}:${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String _formatDateTime(Timestamp timestamp) {
    try {
      final dateTime = timestamp.toDate();
      final months = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر'
      ];

      final weekDays = [
        'الإثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
        'الأحد'
      ];

      final weekDay = weekDays[dateTime.weekday - 1];
      final month = months[dateTime.month - 1];

      return '$weekDay ${dateTime.day} $month';
    } catch (e) {
      return '--';
    }
  }

  String _formatTime(Timestamp timestamp) {
    try {
      final dateTime = timestamp.toDate();
      final hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = hour < 12 ? 'صباحاً' : 'مساءً';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    } catch (e) {
      return '--:--';
    }
  }

  Widget _buildCountdownWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDC2626), Color(0xFF991B1B)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'المتبقي علي المباراة',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 247, 243, 243),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatCountdown(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(String imageUrl, String teamName, bool isHomeTeam) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: isHomeTeam
                  ? Image.asset('assets/logo.png', fit: BoxFit.contain)
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.sports_soccer,
                            size: 30, color: Colors.grey.shade400);
                      },
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            teamName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStadiumInfo(Map<String, dynamic> matchData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.stadium, size: 20, color: Colors.green.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              matchData['location'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(46, 125, 50, 1),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsWithVS(Map<String, dynamic> matchData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red.shade50, Colors.white],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade100, width: 1.5),
      ),
      child: Row(
        children: [
          _buildTeamSection('assets/logo.png', 'الرائد', true),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDC2626), Color(0xFF991B1B)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              'VS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildTeamSection(
            matchData['away_team']['image'],
            matchData['away_team']['name'],
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeInfo(Timestamp timestamp) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month,
                        size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 6),
                    Text(
                      'التاريخ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDateTime(timestamp),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time,
                        size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 6),
                    Text(
                      'الوقت',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(timestamp),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllMatchesButton() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (widget.onViewAllMatches != null) {
              widget.onViewAllMatches!();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MatchesPage()),
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'عرض المباريات القادمة',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0x40FFFFFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildShimmerLoading();
    }

    if (_currentMatchData == null) {
      return _buildNoMatchesWidget();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFF8F9FA)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.sports_soccer,
                        color: Colors.red, size: 24),

                    const SizedBox(width: 8),
                    const Text(
                      'المباراة القادمة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const Spacer(),
                    _buildCountdownWidget(), 
                  ],
                ),
                const SizedBox(height: 20),
                _buildTeamsWithVS(_currentMatchData!),
                const SizedBox(height: 8),
                _buildStadiumInfo(_currentMatchData!),
                const SizedBox(height: 8),
                _buildDateTimeInfo(_currentMatchData!['time'] as Timestamp),
                _buildViewAllMatchesButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                width: 120,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildShimmerCircle(),
              const SizedBox(width: 12),
              Expanded(child: _buildShimmerBox()),
              const SizedBox(width: 12),
              _buildShimmerCircle(),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerCircle() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildShimmerBox() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildNoMatchesWidget() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.sports_soccer, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'لا توجد مباريات قادمة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'سيتم تحديث البيانات قريباً',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          if (widget.onViewAllMatches != null) _buildViewAllMatchesButton(),
        ],
      ),
    );
  }
}
