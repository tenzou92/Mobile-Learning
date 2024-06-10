import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  Widget _buildCrown(int index) {
    switch (index) {
      case 0:
        return const Icon(Icons.emoji_events, color: Colors.amber, size: 24); // Gold crown
      case 1:
        return const Icon(Icons.emoji_events, color: Colors.grey, size: 24); // Silver crown
      case 2:
        return const Icon(Icons.emoji_events, color: Colors.brown, size: 24); // Bronze crown
      default:
        return const SizedBox.shrink(); // No crown for others
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('leaderboard').orderBy('score', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading leaderboard"));
          }

          var users = snapshot.data?.docs ?? [];
          if (users.isEmpty) {
            return const Center(child: Text("No users on the leaderboard"));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCrown(1),
                    const SizedBox(width: 16),
                    _buildCrown(0),
                    const SizedBox(width: 16),
                    _buildCrown(2),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index].data() as Map<String, dynamic>?;
                    var profilePicUrl = user != null && user.containsKey('profilePicUrl') ? user['profilePicUrl'] : '';
                    var name = user != null && user.containsKey('name') ? user['name'] : 'Unknown';
                    var score = user != null && user.containsKey('score') ? user['score'] : 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: profilePicUrl.isNotEmpty
                                ? NetworkImage(profilePicUrl)
                                : const AssetImage('assets/images/bg.jpeg') as ImageProvider,
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (index < 3) _buildCrown(index), // Show crown for top 3
                            ],
                          ),
                          trailing: Text(
                            '$score XP',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
