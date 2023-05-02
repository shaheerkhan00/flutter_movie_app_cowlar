import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app_cowlar/screens/cinemaSeat.dart';

class SeatBookScreen extends StatefulWidget {
  //const SeatBookScreen({Key? key}) : super(key: key);
  static const routeName = '/seat-book';
  @override
  State<SeatBookScreen> createState() => _SeatBookScreenState();
}

class _SeatBookScreenState extends State<SeatBookScreen> {
  late String _title = "";
  late String _releaseDate = '';
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _title = arguments['title'];

    _releaseDate = arguments['releaseDate'];
  }

  int _selectedIndex = 0;
  int _selectedIndexCinema = 0;

  int _regFare = 25;
  int _bonusFare = 2000;

  final List<String> _dates = [
    "5th May",
    "6th May",
    "7th May",
    "8th May",
    "9th May"
  ];
  final List<String> _times = [
    "12:30",
    "13:30",
    "15:30",
    "17:30",
  ];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back.svg',
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Column(
            children: [
              Text(
                _title,
                style: GoogleFonts.poppins(
                    color: Color(0xFF202C43),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'In Theaters $_releaseDate',
                style: GoogleFonts.poppins(
                    color: Color(0xFF61C3F2),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
      body: LayoutBuilder(builder: (context, constraints) {
        final double maxHeight = constraints.maxHeight;
        final double maxWidth = constraints.maxWidth;
        final bool isPortrait = maxHeight > maxWidth;

        return SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 50)),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Date',
                style: GoogleFonts.poppins(
                    color: Color(0xFF202C43),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              height:
                  isPortrait ? deviceHeight * (30 / 813) : deviceHeight * 0.1,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: _dates.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = i;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: _selectedIndex == i
                                ? Colors.blue
                                : Color.fromARGB(40, 166, 166, 166),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          _dates[i],
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _selectedIndex == i
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: deviceHeight * (60 / 813),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              height: isPortrait ? deviceHeight * (200 / 813) : deviceHeight,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: _times.length,
                  itemBuilder: (_, i) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndexCinema = i;
                            print('cinema ${_dates[i]}');
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${_times[i]} ',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF202C43),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'CineTech + Hall ${i + 1}',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF8F8F8F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _selectedIndexCinema == i
                                        ? Color(0xFF61C3F2)
                                        : Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                width: deviceWidth * (250 / 375),
                                height: isPortrait
                                    ? deviceHeight * (145 / 813)
                                    : deviceHeight * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/icons/cinema.png',
                                    width: isPortrait
                                        ? deviceWidth * (145 / 375)
                                        : deviceWidth * 0.5,
                                    height: deviceHeight * (113 / 813),
                                  ),
                                )),
                            Row(
                              children: [
                                Text(
                                  'From ',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF8F8F8F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '\$ ${i * _regFare + 50}',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF202C43),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  ' Or ',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF8F8F8F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '\$ ${_bonusFare + 500 + i * 500} Bonus',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF202C43),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        );
      }),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CinemaSeatBookScreen.routeName, arguments: {
            'title': _title,
            'cinemaDate': _dates[_selectedIndex],
            'cinemaTime': _times[_selectedIndexCinema]
          });
        },
        child: Container(
          width: double.infinity,
          height: deviceHeight > deviceWidth
              ? deviceHeight * (60 / 813)
              : deviceHeight * 0.15,
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/icons/SelectSeatsBtn.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Select Seats',
                  style: GoogleFonts.poppins(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
