import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app_cowlar/screens/moviedetail.dart';
import 'package:movie_app_cowlar/screens/movielist.dart';
import 'package:movie_app_cowlar/screens/moviesearch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './moviesearch.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      MovieListScreen(),
      MovieSearchScreen(),
      MovieSearchScreen(),
      MovieListScreen(),
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          color: Color(0xFF2E2739),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _selectPage,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,

            backgroundColor: Color(0xFF2E2739),
            //backgroundColor: Colors.grey,

            items: [
              BottomNavigationBarItem(
                icon: Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(left: 50),
                  child: _selectedPageIndex == 0
                      ? SvgPicture.asset(
                          'assets/icons/homeicon.svg',
                          color: Colors.white,
                        )
                      : SvgPicture.asset('assets/icons/homeicon.svg'),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedPageIndex == 1
                    ? SvgPicture.asset(
                        'assets/icons/Watch.svg',
                      )
                    : SvgPicture.asset(
                        'assets/icons/Watch.svg',
                        color: Colors.grey,
                      ),
                label: 'Watch',
              ),
              BottomNavigationBarItem(
                icon: _selectedPageIndex == 2
                    ? SvgPicture.asset(
                        'assets/icons/media.svg',
                        color: Colors.white,
                      )
                    : SvgPicture.asset('assets/icons/media.svg'),
                label: 'Media Library',
                // backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: _selectedPageIndex == 3
                    ? SvgPicture.asset('assets/icons/Vector.svg')
                    : SvgPicture.asset(
                        'assets/icons/Vector.svg',
                        color: Colors.grey,
                      ),
                label: 'More',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
