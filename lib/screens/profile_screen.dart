import 'package:flutter/material.dart';
import 'EditProfile_screen.dart';
import 'setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static final Color darkGreen = Color(0xFF013220);
  static final Color olive = Color(0xFF3E4E3B);
  static final Color black = Color(0xFF111111);
  static final Color pri_green = Color.fromARGB(255, 121, 207, 97);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Stack(
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.white,
              ),
            ),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: pri_green,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsApp()),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/00.png'),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = .5
                        ..color = const Color.fromARGB(
                            166, 136, 214, 141), // White stroke
                    ),
                  ),
                  Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 26,
                      letterSpacing: 1.5,
                      color: const Color.fromARGB(255, 244, 244, 244),
                    ),
                  ),
                ],
              ),
              Text(
                'Stay active and healthy',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color.fromARGB(255, 232, 232, 232)
                        .withOpacity(0.7)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: darkGreen,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text('Edit Profile', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(
                    label: 'Steps',
                    value: '6,000',
                    color: darkGreen,
                  ),
                  StatCard(
                    label: 'Calories',
                    value: '2,400',
                    color: olive,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCard(
                    label: 'Workout time',
                    value: '3h',
                    color: olive,
                  ),
                  StatCard(
                    label: 'Sleep',
                    value: '7hr',
                    color: darkGreen,
                  ),
                ],
              ),
              SizedBox(height: 20),
              StatCard(
                label: 'Weight',
                value: '110lb',
                color: black,
                isFullWidth: true,
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Goals',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 244, 244, 244),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GoalItem(
                label: 'Daily Steps',
                color: darkGreen,
                onPressed: () {},
              ),
              GoalItem(
                label: 'Workout Time',
                color: olive,
                onPressed: () {},
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: darkGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text('Sync with Google Fit',
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isFullWidth;

  StatCard({
    required this.label,
    required this.value,
    required this.color,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth
          ? double.infinity
          : MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class GoalItem extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  GoalItem({required this.label, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 18, color: Colors.black)),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text('Change', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
