import 'package:flutter/material.dart';


class DeveloperPage extends StatelessWidget {
   DeveloperPage({super.key});

  // Define a class for Developer
  final List<Developer> _developers = [
    Developer(
      name: '@samyiss',
      githubLink: 'https://github.com/samyiss',
      imageUrl: 'https://avatars.githubusercontent.com/u/98336943?v=4',
    ),
    Developer(
      name: 'P1xlized',
      githubLink: 'https://github.com/p1xlized',
      imageUrl: 'https://avatars.githubusercontent.com/u/72890769?v=4',
    ),
    Developer(
      name: 'NathanDecopain',
      githubLink: 'https://github.com/NathanDecopain',
      imageUrl: 'https://avatars.githubusercontent.com/u/68757668?v=4',
    ),
    Developer(
      name: 'GiardMathieu',
      githubLink: 'https://github.com/GiardMathieu',
      imageUrl: 'https://avatars.githubusercontent.com/u/157785927?v=4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet the Developers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          // GridView to display developers in a grid
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 developers per row
            crossAxisSpacing: 20, // Horizontal space between cards
            mainAxisSpacing: 20, // Vertical space between cards
            childAspectRatio: 0.75, // Aspect ratio of each card
          ),
          itemCount: _developers.length, // Use the length of the developer list
          itemBuilder: (context, index) {
            final developer = _developers[index];
            return _developerCard(developer);
          },
        ),
      ),
    );
  }

  // Helper method to create a developer card
  Widget _developerCard(Developer developer) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(developer.imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            developer.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          IconButton(
            icon: const Icon(Icons.link),
            onPressed: () {
              // Open GitHub link
              _launchURL(developer.githubLink);
            },
          ),
        ],
      ),
    );
  }

  // Helper method to launch the URL
  void _launchURL(String url) {
    // Use a package like 'url_launcher' to open the URL
    // Here we just print for simplicity
    print('Opening URL: $url');
  }
}

// Define a class for the Developer model
class Developer {
  final String name;
  final String githubLink;
  final String imageUrl;

  Developer({
    required this.name,
    required this.githubLink,
    required this.imageUrl,
  });
}