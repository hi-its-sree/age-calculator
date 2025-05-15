import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rentzy/Database/InviteFriends.dart';

class InviteFriendsPage extends StatefulWidget {
  const InviteFriendsPage({super.key});

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  List<int> inviteStates = [];
  List<Map<String, dynamic>>? friendDetails = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      List<Map<String, dynamic>>? details = await InviteFriends().InviteDetails();
      setState(() {
        friendDetails = details;
        filteredFriends = List.from(friendDetails ?? []);
        inviteStates = List.filled(friendDetails?.length ?? 0, 0);
      });
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  void filterFriends(String query) {
    setState(() {
      filteredFriends = friendDetails?.where((friend) {
        final name = friend['name'].toString().toLowerCase();
        final number = friend['number'].toString().toLowerCase();
        return name.contains(query.toLowerCase()) ||
            number.contains(query.toLowerCase());
      }).toList() ?? [];
    });
  }

  void inviteFriend(int index, BuildContext context) {
    setState(() {
      inviteStates[index] = 1;
    });

    final friendName = filteredFriends[index]['name'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invitation sent to $friendName!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              inviteStates[index] = 0;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Invite Friends",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: filterFriends,
                decoration: InputDecoration(
                  hintText: 'Search friends...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // Friends List
            Expanded(
              child: RefreshIndicator(
                onRefresh: loadDetails,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredFriends.length,
                  itemBuilder: (context, index) {
                    final friend = filteredFriends[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: MemoryImage(
                            base64Decode(friend['dp'] ?? ''),
                          ),
                        ),
                        title: Text(
                          friend['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          friend['number'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: inviteStates[index] == 1
                                ? Colors.grey.shade100
                                : theme.primaryColor,
                            foregroundColor: inviteStates[index] == 1
                                ? Colors.black
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: inviteStates[index] == 1
                                  ? const BorderSide(color: Colors.black)
                                  : BorderSide.none,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          onPressed: () => inviteFriend(index, context),
                          child: Text(
                            inviteStates[index] == 1 ? 'Invited' : 'Invite',
                            style: const TextStyle(fontSize: 14),
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}