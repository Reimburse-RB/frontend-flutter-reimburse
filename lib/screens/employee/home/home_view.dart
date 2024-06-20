import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/menu_category_data.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/list_horizontal_menu.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.moveToAnotherTab});

  final Function(int) moveToAnotherTab;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(moveToAnotherTab: moveToAnotherTab),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGeneral(
          context: context,
          isHasCustomLeading: false,
          customImage: 'assets/apps_logo/logo-horizontal-white-reimburserb.png',
          lightenImage: true,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 24),
            ListView.builder(
              itemCount: viewModel.listMenuCategory.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                MenuCategoryData menuCategoryData = viewModel.listMenuCategory[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListHorizontalMenu(
                      menuCategory: menuCategoryData,
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
