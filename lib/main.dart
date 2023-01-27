import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingo/models/dashboard_model.dart';
import 'package:thingo/screens/url_short.dart';
import 'package:thingo/screens/wa_status.dart';
import 'package:thingo/screens/wa_text.dart';
import 'package:thingo/screens/spy_cam.dart';
import 'package:thingo/service/url_service.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:thingo/widgets/custom_grid_view.dart';
import 'package:quick_actions/quick_actions.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
        ),
        scaffoldBackgroundColor: AppColor.backgroundLight,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UrlService(),
          ),
        ],
        child: const DashBoard(),
      ),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List<DashboardModel> _dashboardModelList = [];

  @override
  void initState() {
    _dashboardModelList = [
      DashboardModel(
        title: 'WhatsApp Direct Chat',
        backgroundColor: AppColor.gridOrange,
        screen: const WaText(),
        animation: 'assets/animations/message.json',
      ),
      // DashboardModel(
      //   title: 'View Instagram Profile',
      //   backgroundColor: AppColor.gridBlue,
      //   screen: const IgProfileInfo(),
      //   animation: 'assets/animations/find-person.json',
      // ),
      DashboardModel(
        title: 'View WhatsApp Status',
        backgroundColor: AppColor.gridGreen,
        screen: const WaStatus(),
        animation: 'assets/animations/status.json',
      ),
      DashboardModel(
        title: 'URL Shortener',
        backgroundColor: AppColor.gridRed,
        screen: const UrlShort(),
        animation: 'assets/animations/url.json',
      ),
      DashboardModel(
        title: 'Spy Cam',
        backgroundColor: AppColor.gridYellow,
        screen: const SpyCam(),
        animation: 'assets/animations/spy.json',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'THINGO',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColor.primaryColor,
            letterSpacing: 1.5,
            decoration: TextDecoration.overline,
            decorationThickness: 3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,),
        child: CustomGridView(
          dashboardList: _dashboardModelList,
        ),
      ),
    );
  }
}

