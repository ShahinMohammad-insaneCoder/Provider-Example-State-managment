import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_style.dart';
import '../../business_logic/provider/bag_provider.dart';
import '../../data/model/bag.dart';
import '../widget/bag_list_view.dart';
import 'office_bag_detail_screen.dart';


class OfficeBagListScreen extends StatelessWidget {
  const OfficeBagListScreen({Key? key}) : super(key: key);

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Hello Shahin", style: h2Style),
                  Text("Buy Your favorite desk", style: h3Style),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: const Icon(Icons.menu, color: Colors.grey),
          contentPadding: const EdgeInsets.all(20),
          border: textFieldStyle,
          focusedBorder: textFieldStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Bag> items =
        context.watch<BagProvider>().state.mainItems;

    Future<Widget?> navigate(Bag furniture, int index) {
      return Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) =>
              ChangeNotifierProvider.value(
            value: context.read<BagProvider>(),
            child:
                OfficeBagDetailScreen(furniture: furniture, index: index),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            _searchBar(),
            FurnitureListView(furnitureList: items, onTap: navigate),
            const Text("Popular", style: h2Style),
            FurnitureListView(
              furnitureList: items,
              isHorizontal: false,
              onTap: navigate,
            ),
          ],
        ),
      ),
    );
  }
}
