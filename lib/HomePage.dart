import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    PostPage(postType: 'Text', content: 'This is a sample text post.'),
    PostPage(postType: 'Video', content: 'Watch this sample video.'),
    PostPage(postType: 'Image', content: 'This is a sample image post.'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text('MINDLINK TASK')),
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'Text Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image Post',
          ),
        ],
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  final String postType;
  final String content;

  PostPage({required this.postType, required this.content});

  void _sharePost(BuildContext context, String postType) {
    String postLink = 'https://example.com/post/${postType.toLowerCase()}';

    Share.share('Check out this $postType post: $postLink');
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Post Type: $postType',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(content, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _sharePost(context, postType),
            child: Text('Share this $postType post'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _launchURL('https://www.google.co.in'),
            child: Text('Open post in browser'),
          ),
        ],
      ),
    );
  }
}
