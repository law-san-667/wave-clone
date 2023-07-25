import 'package:exam_flutter_wave/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Exam flutter Wave remix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(size: size),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String price = "219";
  IconData icon = Icons.visibility;
  String devise = "F";
  final transactions = transactionsList;
  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.18),
        child: SizedBox(
          height: size.height * 0.18,
          child: CupertinoNavigationBar(
            backgroundColor: backgroundColor,
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: size.width * 0.09,
            ),
            middle: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width * 0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.09,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      devise,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                      height: size.height * 0.06,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          onPressed: () {
                            //onclicked the button will toggle the visibility of the price
                            //what will be displayed is "*****" and the icon will change to "eye slash icon
                            setState(() {
                              if (icon == Icons.visibility) {
                                icon = Icons.visibility_off;
                                price = "*****";
                                devise = "";
                              } else {
                                icon = Icons.visibility;
                                price = "219";
                                devise = "F";
                              }
                            });
                          },
                          icon: //eye icon
                              Icon(
                            icon,
                            color: Colors.white,
                            size: size.width * 0.05,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.4,
              color: backgroundColor,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MainButtonsSection(size: size),
                    ],
                  ),
                  CardWithQrSection(size: size),
                ],
              ),
            ),
            //List of transactions
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    transactions[index]["type"] +
                        " " +
                        transactions[index]["person"],
                    style: TextStyle(
                      color: backgroundColor,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    transactions[index]["date"],
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "${transactions[index]["amount"]}F",
                    style: TextStyle(
                      color: backgroundColor,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardWithQrSection extends StatelessWidget {
  const CardWithQrSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.7,
          height: size.height * 0.25,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: size.width * 0.02,
              bottom: size.width * 0.02,
              left: size.width * 0.17,
              right: size.width * 0.17,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomPaint(
                      size: Size(
                        size.height * 0.17,
                        size.height * 0.17,
                      ),
                      painter: QrPainter(
                        data: "qrData",
                        version: QrVersions.auto,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //camera icon & and text "scan"
                        Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: size.width * 0.04,
                        ),
                        Text(
                          " Scan",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MainButtonsSection extends StatelessWidget {
  const MainButtonsSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.05,
              right: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //four image circles containers that will be buttons with an image inside
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.blue[600]!.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: const Color.fromARGB(255, 56, 28, 104),
                        size: size.width * 0.09,
                      ),
                    ),
                  ),
                  const Text(
                    "Send",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_basket_sharp,
                        color: Colors.orange,
                        size: size.width * 0.09,
                      ),
                    ),
                  ),
                  const Text(
                    "Payments",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.blue[600]!.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone_android_rounded,
                        color: Colors.lightBlue,
                        size: size.width * 0.09,
                      ),
                    ),
                  ),
                  const Text(
                    "Airtime",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.15,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.account_balance,
                        color: Colors.deepPurple,
                        size: size.width * 0.09,
                      ),
                    ),
                  ),
                  const Text(
                    "Bank",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
