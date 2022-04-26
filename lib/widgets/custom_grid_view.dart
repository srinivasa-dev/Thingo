import 'package:flutter/material.dart';
import 'package:thingo/globals.dart';
import 'package:thingo/models/dashboard_model.dart';
import 'package:thingo/utils/app_color.dart';
import 'package:lottie/lottie.dart';

class CustomGridView extends StatefulWidget {

  final List<DashboardModel> dashboardList;
  
  const CustomGridView({Key? key, required this.dashboardList}) : super(key: key);

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Globals().getOrientation(context) == Orientation.portrait ? 2 : 4,
        childAspectRatio: 1.0,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: widget.dashboardList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => widget.dashboardList[index].screen,));
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            elevation: 5.0,
            color: widget.dashboardList[index].backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 3.0, 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: Text(
                      widget.dashboardList[index].title,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGrey1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Lottie.asset(
                      widget.dashboardList[index].animation,
                      width: 50,
                      height: 50,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
