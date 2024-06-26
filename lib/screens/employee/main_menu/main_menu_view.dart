import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/employee/home/home_view.dart';
import 'package:reimburse_rb/screens/employee/notification/notification_view.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_home/submission_home_view.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'main_menu_view_model.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainMenuViewModel(),
      child: const MainMenuView(),
    );
  }
}

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainMenuViewModel>(context);

    List<Widget> pages = [
      HomeScreen(moveToAnotherTab: viewModel.onItemTapped),
      const SubmissionHomeScreen(),
      const NotificationScreen(),
      const Scaffold(),
      // DetectionHomePage(moveToAnotherTab: viewModel.onItemTapped),
      // const MainProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () => viewModel.onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: pages[viewModel.selectedIndex],
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: BottomNavigationBar(
              selectedFontSize: 10,
              unselectedFontSize: 10,
              unselectedLabelStyle: const TextStyle(color: Constant.grey),
              unselectedItemColor: Constant.grey,
              selectedLabelStyle: const TextStyle(color: Constant.greenDark),
              selectedItemColor: Constant.greenDark,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              currentIndex: viewModel.selectedIndex,
              onTap: viewModel.onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: viewModel.selectedIndex == 0
                      ? const Icon(
                          IconlyLight.home,
                        )
                      : const Icon(
                          IconlyBroken.home,
                        ),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: viewModel.selectedIndex == 1
                      ? const Icon(
                          IconlyLight.paper,
                        )
                      : const Icon(
                          IconlyBroken.paper,
                        ),
                  label: 'Pengajuan',
                ),
                BottomNavigationBarItem(
                  icon: viewModel.selectedIndex == 2
                      ? const Icon(
                          IconlyLight.notification,
                        )
                      : const Icon(
                          IconlyBroken.notification,
                        ),
                  label: 'Notifikasi',
                ),
                BottomNavigationBarItem(
                  icon: viewModel.selectedIndex == 2
                      ? const Icon(
                          IconlyLight.profile,
                        )
                      : const Icon(
                          IconlyBroken.profile,
                        ),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
