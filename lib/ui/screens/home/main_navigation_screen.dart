import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreen();
}

class _MainNavigationScreen extends State<MainNavigationScreen> {
  PageController controller = PageController(initialPage: 0);
  var selected = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            selected = index;
          });
        },
        children: const [
          Center(child: Text('Category')),
          Center(child: Text('Nearby ')),
          Center(child: Text('Home')),
          Center(child: Text('Chat')),
          Center(child: Text('Profile')),
          // Home(),
          // Add(),
          // Profile(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          // barStyle: BubbleBarStyle.vertical,
          barStyle: BubbleBarStyle.horizotnal,
          bubbleFillStyle: BubbleFillStyle.outlined,
          // bubbleFillStyle: BubbleFillStyle.outlined,
          opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.menu),
            title: const Text('Category'),
            backgroundColor: const Color.fromARGB(255, 255, 42, 35),
            borderColor: const Color.fromARGB(255, 255, 42, 35),

            // selectedColor: Colors.pink,
            selectedIcon: const Icon(Icons.read_more),
            badge: const Text('1+'),
            badgeColor: const Color.fromARGB(255, 255, 42, 35),
            showBadge: false,
          ),
          BottomBarItem(
            icon: const Icon(Icons.map),
            title: const Text('Nearby'),
            backgroundColor: const Color.fromARGB(255, 255, 42, 35),
            borderColor: const Color.fromARGB(255, 255, 42, 35),
          ),
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            borderColor: const Color.fromARGB(255, 255, 42, 35),
            backgroundColor: const Color.fromARGB(255, 255, 42, 35),
          ),
          BottomBarItem(
            icon: const Icon(Icons.chat_bubble),
            title: const Text('Chat'),
            backgroundColor: const Color.fromARGB(255, 255, 42, 35),
            borderColor: const Color.fromARGB(255, 255, 42, 35),
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            backgroundColor: const Color.fromARGB(255, 255, 42, 35),
            borderColor: const Color.fromARGB(255, 255, 42, 35),
          ),
        ],
        // fabLocation: StylishBarFabLocation.end,
        // hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            controller.jumpToPage(index);
          });
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.emoji_emotions),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
