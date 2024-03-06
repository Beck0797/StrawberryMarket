import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreen();
}

class _MainNavigationScreen extends State<MainNavigationScreen> {
  PageController controller = PageController(initialPage: 2);
  var selected = 2;
  String _selectedCity = 'London';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            DropdownButton<String>(
              value: _selectedCity,
              isExpanded: false,
              icon: SvgPicture.asset('assets/icons/ic_arrow_down.svg',
                  semanticsLabel: 'Icon Down'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: "New York",
                  child: Text(
                    "New York",
                    style: GoogleFonts.mukta(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "Paris",
                  child: Text(
                    "Paris",
                    style: GoogleFonts.mukta(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "London",
                  child: Text(
                    "London",
                    style: GoogleFonts.mukta(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 42, 35),
                        ),
                      ),
                    ),
                    SizedBox(
                      // width: double.infinity,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              // padding: const EdgeInsets.all(8.0),
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Post'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/ic_notification.svg'),
              onPressed: () {},
            ),
          ],
        ),
      ),

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
