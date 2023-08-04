import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/colors.dart';
import 'profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(labelText: 'Search for an user'),
          onFieldSubmitted: (_) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return (snapshot.data! as dynamic).docs.length != 0
                    ? ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length ?? 0,
                        itemBuilder: (context, index) {
                          final searchData =
                              (snapshot.data! as dynamic).docs[index];
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  uid: searchData['uid'],
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  searchData['photoUrl'],
                                ),
                              ),
                              title: Text((snapshot.data! as dynamic)
                                  .docs[index]['username']),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "No Users Found",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
              },
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .where('username', isLessThan: _searchController.text + "z")
                  .get(),
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MasonryGridView.count(
                    // staggeredTileBuilder: (index) => StaggeredTile.count(
                    //       (index % 7 == 0) ? 2 : 1,
                    //       (index % 7 == 0) ? 2 : 1,
                    //     ),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    crossAxisCount: 3,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) => Image.network(
                        (snapshot.data! as dynamic).docs[index]['postUrl']));
              },
            ),
    );
  }
}
