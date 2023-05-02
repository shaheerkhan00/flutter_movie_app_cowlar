import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CinemaSeatBookScreen extends StatefulWidget {
  static const routeName = '/cinema-seat';

  @override
  State<CinemaSeatBookScreen> createState() => _CinemaSeatBookScreenState();
}

class _CinemaSeatBookScreenState extends State<CinemaSeatBookScreen> {
  // Define the state variables for the cinema seat booking widget
  //int numRows = 10;
  //int numCols = 24;
  int selectedRow = -1;
  int selectedCol = -1;
  int numRows = 24;
  int numCols = 10;
  int premiumSeatPrice = 150;
  int regularSeatPrice = 50;
  var selectedSeatR = 0;
  var selectedSeatC = 0;

  List<List<int>> seatTypes = List.generate(24, (index) => List.filled(10, 0));
  int totalCost = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the state variables here if necessary
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double _scale = 1.0;
    double _previousScale = 1.0;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String _title = arguments['title'];
    final String _cinemaDate = arguments['cinemaDate'];
    final String _cinemaTime = arguments['cinemaTime'];

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
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$_cinemaDate | $_cinemaTime',
              style: GoogleFonts.poppins(
                color: Color(0xFF61C3F2),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final double maxHeight = constraints.maxHeight;
        final double maxWidth = constraints.maxWidth;
        final bool isPortrait = maxHeight > maxWidth;
        return !isPortrait
            ? Container(
                height: isPortrait ? deviceHeight * 0.6 : deviceHeight * 0.8,
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: deviceHeight * (50 / 813),
                        ),
                        Container(
                            child: SvgPicture.asset('assets/icons/screen.svg')),
                        //Container(
                        //alignment: Alignment.center, child: Text('SCREEN')),
                        // SizedBox(
                        //  height: deviceHeight * (50 / 813),
                        // ),
                        SingleChildScrollView(
                          child: Center(
                            child: Container(
                              width: isPortrait
                                  ? deviceWidth * (330 / 375)
                                  : deviceWidth / 2.5,
                              height: deviceHeight * (200 / 813),
                              child: Transform.scale(
                                scale: 1.0,
                                child: GridView.count(
                                  crossAxisCount: 24,
                                  children: List.generate(
                                    numRows * numCols,
                                    (index) => Container(
                                      height: 1,
                                      width: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (index == 0 ||
                                                index == 1 ||
                                                index == 2 ||
                                                index == 21 ||
                                                index == 22 ||
                                                index == 23 ||
                                                index == 24 ||
                                                index == 48 ||
                                                index == 72 ||
                                                index == 47 ||
                                                index == 71 ||
                                                index == 95 ||
                                                index == 5 ||
                                                index == 29 ||
                                                index == 53 ||
                                                index == 77 ||
                                                index == 101 ||
                                                index == 25 ||
                                                index == 149 ||
                                                index == 173 ||
                                                index == 197 ||
                                                index == 221 ||
                                                index == 5 + 13 ||
                                                index == 29 + 13 ||
                                                index == 53 + 13 ||
                                                index == 77 + 13 ||
                                                index == 101 + 13 ||
                                                index == 25 + 13 ||
                                                index == 149 + 13 ||
                                                index == 173 + 13 ||
                                                index == 197 + 13 ||
                                                index == 221 + 13) {
                                              return;
                                            }
                                            selectedSeatR = (index / 24).ceil();
                                            selectedSeatC = index % 24;

                                            print(index);
                                            int row = (index / numCols).floor();
                                            int col = index % numCols;
                                            if (seatTypes[row][col] == 0) {
                                              if (index > 215 && index < 240) {
                                                seatTypes[row][col] = 2;
                                                totalCost += premiumSeatPrice;
                                              } else {
                                                seatTypes[row][col] = 1;
                                                totalCost += regularSeatPrice;
                                              }
                                              // Update the selected row and column
                                              selectedRow = row;
                                              selectedCol = col;
                                            } else {
                                              if (seatTypes[row][col] == 2) {
                                                totalCost -= premiumSeatPrice;
                                              } else {
                                                totalCost -= regularSeatPrice;
                                              }
                                              seatTypes[row][col] = 0;
                                              selectedRow = -1;
                                              selectedCol = -1;
                                            }
                                            if (selectedRow != -1 &&
                                                selectedCol != -1) {
                                              index = selectedRow * numCols +
                                                  selectedCol;
                                            }
                                          });
                                        },
                                        child: ZoomableSizedBox(
                                          child: SizedBox(
                                            child: (index == 0 ||
                                                    index == 1 ||
                                                    index == 2 ||
                                                    index == 21 ||
                                                    index == 22 ||
                                                    index == 23 ||
                                                    index == 24 ||
                                                    index == 48 ||
                                                    index == 72 ||
                                                    index == 47 ||
                                                    index == 71 ||
                                                    index == 95 ||
                                                    index == 5 ||
                                                    index == 29 ||
                                                    index == 53 ||
                                                    index == 77 ||
                                                    index == 101 ||
                                                    index == 25 ||
                                                    index == 149 ||
                                                    index == 173 ||
                                                    index == 197 ||
                                                    index == 221 ||
                                                    index == 5 + 13 ||
                                                    index == 29 + 13 ||
                                                    index == 53 + 13 ||
                                                    index == 77 + 13 ||
                                                    index == 101 + 13 ||
                                                    index == 149 + 13 ||
                                                    index == 173 + 13 ||
                                                    index == 197 + 13 ||
                                                    index == 221 + 13 ||
                                                    index == 125 + 13 ||
                                                    index == 125)
                                                ? Container(
                                                    color: Colors.white,
                                                  )
                                                : SvgPicture.asset(
                                                    seatTypes[index ~/ numCols][
                                                                index %
                                                                    numCols] ==
                                                            0
                                                        ? index > 215 &&
                                                                index < 240
                                                            ? 'assets/icons/premium.svg'
                                                            : 'assets/icons/regular.svg'
                                                        : 'assets/icons/selected_seat.svg',
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: isPortrait
                            ? deviceHeight * (250 / 813)
                            : deviceHeight * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/selected_seat.svg'),
                                  Text(
                                    '  Selected     ',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF8F8F8F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: deviceWidth * (20 / 375),
                                  ),
                                  SvgPicture.asset('assets/icons/notavail.svg'),
                                  Text(
                                    '  Not Available',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF8F8F8F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/premium.svg'),
                                  Text(
                                    '  Vip ( 150\$ )',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF8F8F8F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: deviceWidth * (20 / 375),
                                  ),
                                  SvgPicture.asset('assets/icons/regular.svg'),
                                  Text(
                                    '  Regular ( 50\$ )',
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF8F8F8F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * (10 / 813),
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: isPortrait
                                        ? deviceWidth * (97 / 375)
                                        : deviceWidth * 0.1,
                                    height: isPortrait
                                        ? deviceHeight * (30 / 813)
                                        : deviceHeight * 0.05,
                                    // color: Color.fromARGB(65, 166, 166, 166),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$selectedSeatC /',
                                            style: GoogleFonts.poppins(
                                                color: Color(0xFF202c43),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '$selectedSeatR row',
                                            style: GoogleFonts.poppins(
                                                color: Color(0xFF202c43),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: isPortrait
                                        ? deviceWidth * (108 / 375)
                                        : deviceWidth * 0.2,
                                    height: isPortrait
                                        ? deviceHeight * (50 / 813)
                                        : deviceHeight * 0.1,
                                    //   color: Color.fromARGB(65, 166, 166, 166),
                                    child: Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: deviceHeight * 0.05,
                                                ),
                                                Text('   Total Amount:'),
                                                Text('\$$totalCost',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * (10 / 813),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print('done');
                                  },
                                  child: Container(
                                    width: deviceWidth * (200 / 375),
                                    height: isPortrait
                                        ? deviceHeight * (65 / 813)
                                        : deviceHeight * 0.12,
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
                                            'Proceed to Pay',
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: deviceHeight * (50 / 813),
                  ),
                  SvgPicture.asset('assets/icons/screen.svg'),
                  //Container(alignment: Alignment.center, child: Text('SCREEN')),
                  // SizedBox(
                  //height: deviceHeight * (50 / 813),
                  //  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Container(
                        width: deviceWidth * (330 / 375),
                        height: deviceHeight * (200 / 813),
                        child: Transform.scale(
                          scale: 1.0,
                          child: GridView.count(
                            crossAxisCount: 24,
                            children: List.generate(
                              numRows * numCols,
                              (index) => Container(
                                height: 1,
                                width: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (index == 0 ||
                                          index == 1 ||
                                          index == 2 ||
                                          index == 21 ||
                                          index == 22 ||
                                          index == 23 ||
                                          index == 24 ||
                                          index == 48 ||
                                          index == 72 ||
                                          index == 47 ||
                                          index == 71 ||
                                          index == 95 ||
                                          index == 5 ||
                                          index == 29 ||
                                          index == 53 ||
                                          index == 77 ||
                                          index == 101 ||
                                          index == 25 ||
                                          index == 149 ||
                                          index == 173 ||
                                          index == 197 ||
                                          index == 221 ||
                                          index == 5 + 13 ||
                                          index == 29 + 13 ||
                                          index == 53 + 13 ||
                                          index == 77 + 13 ||
                                          index == 101 + 13 ||
                                          index == 25 + 13 ||
                                          index == 149 + 13 ||
                                          index == 173 + 13 ||
                                          index == 197 + 13 ||
                                          index == 221 + 13) {
                                        return;
                                      }
                                      selectedSeatR = (index / 24).ceil();
                                      selectedSeatC = index % 24;

                                      print(index);
                                      int row = (index / numCols).floor();
                                      int col = index % numCols;
                                      if (seatTypes[row][col] == 0) {
                                        if (index > 215 && index < 240) {
                                          seatTypes[row][col] = 2;
                                          totalCost += premiumSeatPrice;
                                        } else {
                                          seatTypes[row][col] = 1;
                                          totalCost += regularSeatPrice;
                                        }
                                        // Update the selected row and column
                                        selectedRow = row;
                                        selectedCol = col;
                                      } else {
                                        if (seatTypes[row][col] == 2) {
                                          totalCost -= premiumSeatPrice;
                                        } else {
                                          totalCost -= regularSeatPrice;
                                        }
                                        seatTypes[row][col] = 0;
                                        selectedRow = -1;
                                        selectedCol = -1;
                                      }
                                      if (selectedRow != -1 &&
                                          selectedCol != -1) {
                                        index =
                                            selectedRow * numCols + selectedCol;
                                      }
                                    });
                                  },
                                  child: ZoomableSizedBox(
                                    child: SizedBox(
                                      child: (index == 0 ||
                                              index == 1 ||
                                              index == 2 ||
                                              index == 21 ||
                                              index == 22 ||
                                              index == 23 ||
                                              index == 24 ||
                                              index == 48 ||
                                              index == 72 ||
                                              index == 47 ||
                                              index == 71 ||
                                              index == 95 ||
                                              index == 5 ||
                                              index == 29 ||
                                              index == 53 ||
                                              index == 77 ||
                                              index == 101 ||
                                              index == 25 ||
                                              index == 149 ||
                                              index == 173 ||
                                              index == 197 ||
                                              index == 221 ||
                                              index == 5 + 13 ||
                                              index == 29 + 13 ||
                                              index == 53 + 13 ||
                                              index == 77 + 13 ||
                                              index == 101 + 13 ||
                                              index == 149 + 13 ||
                                              index == 173 + 13 ||
                                              index == 197 + 13 ||
                                              index == 221 + 13 ||
                                              index == 125 + 13 ||
                                              index == 125)
                                          ? Container(
                                              color: Colors.white,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: SvgPicture.asset(
                                                seatTypes[index ~/ numCols]
                                                            [index % numCols] ==
                                                        0
                                                    ? index > 215 && index < 240
                                                        ? 'assets/icons/premium.svg'
                                                        : 'assets/icons/regular.svg'
                                                    : 'assets/icons/selected_seat.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }),
      bottomNavigationBar: deviceHeight > deviceWidth
          ? BottomAppBar(
              child: Container(
                padding: EdgeInsets.all(10),
                height: deviceHeight * (250 / 813),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/selected_seat.svg'),
                          Text(
                            '  Selected     ',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF8F8F8F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: deviceWidth * (20 / 375),
                          ),
                          SvgPicture.asset('assets/icons/notavail.svg'),
                          Text(
                            '  Not Available',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF8F8F8F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/premium.svg'),
                          Text(
                            '  Vip ( 150\$ )',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF8F8F8F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: deviceWidth * (20 / 375),
                          ),
                          SvgPicture.asset('assets/icons/regular.svg'),
                          Text(
                            '  Regular ( 50\$ )',
                            style: GoogleFonts.poppins(
                                color: Color(0xFF8F8F8F),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * (10 / 813),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: deviceWidth * (97 / 375),
                        height: deviceHeight * (30 / 813),
                        color: Color.fromARGB(65, 166, 166, 166),
                        child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$selectedSeatC /',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF202c43),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '$selectedSeatR row',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF202c43),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * (10 / 813),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: deviceWidth * (108 / 375),
                            height: deviceHeight * (50 / 813),
                            color: Color.fromARGB(65, 166, 166, 166),
                            child: Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: deviceHeight * (5 / 813),
                                      ),
                                      Text('Total Amount'),
                                      Text('\$$totalCost',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('done');
                          },
                          child: Container(
                            width: deviceWidth * (200 / 375),
                            height: deviceHeight * (65 / 813),
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
                                    'Proceed to Pay',
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
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class ZoomableSizedBox extends StatefulWidget {
  final Widget child;

  const ZoomableSizedBox({Key? key, required this.child}) : super(key: key);

  @override
  _ZoomableSizedBoxState createState() => _ZoomableSizedBoxState();
}

class _ZoomableSizedBoxState extends State<ZoomableSizedBox> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _previousScale = _scale;
      },
      onScaleUpdate: (details) {
        setState(() {
          _scale = _previousScale * details.scale;
        });
      },
      onScaleEnd: (details) {
        _previousScale = 1.0;
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
