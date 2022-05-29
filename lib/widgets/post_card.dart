import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shrinkWrap: true,
                          children: [
                            'Delete',
                          ]
                              .map(
                                (e) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          //Image Section
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.cover,
            ),
          ),
          // Like,Comment Section
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                ),
                onPressed: () {},
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                  ),
                ),
              )
            ],
          ),
          //Description & No. of Comments
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${snap['likes'].length} likes',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                            text: snap['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' ${snap['description']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('View all 200 Comments',
                          style: const TextStyle(
                            fontSize: 16,
                            color: secondaryColor,
                          )),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
