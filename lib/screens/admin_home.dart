import 'package:flutter/material.dart';
import 'package:tododemoapp/screens/register_page.dart';
import 'package:tododemoapp/screens/teacher_registeration.dart';
import 'package:tododemoapp/services/auth_service.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with SingleTickerProviderStateMixin {
  
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home"),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false));
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Container(

              height: 200,
              color: Colors.red,
            ),

            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: TabBar(


                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.green,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Place Bid',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Buy Now',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  TeacherRegister(),

                  // second tab bar view widget
                  Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
