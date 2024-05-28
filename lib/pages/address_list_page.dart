import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/widget_designs.dart';

class AppAddressListPage extends StatefulWidget {
  final dynamic user;
  final bool isDonor;
  const AppAddressListPage({super.key, required this.user, required this.isDonor});

  @override
  State<AppAddressListPage> createState() => _AppAddressesPagesState();
}

class _AppAddressesPagesState extends State<AppAddressListPage> {
  List<String>? addresses = [];

  @override
  void initState() {
    super.initState();
    addresses = widget.isDonor ? widget.user.addressList : widget.user.orgAddressList;
  }

  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: Column(
          children: [
            spacer(40.0),
            _buildHeader(),
            spacer(10.0),
            _buildList(),
          ],
        ),
      ),
      bottomSheet: addAddressButton(context),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        backButton,
        const Text("Your Addresses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset('assets/images/cloud01.png', height: 80),
        )
      ],
    );
  }

  Widget get backButton => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
      );

  Widget _buildList() {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: addresses!.length,
          itemBuilder: ((context, index) {
            String address = addresses![index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
              ),
              // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              // decoration: CustomWidgetDesigns.customTileContainer(),
              child: ListTile(
                minTileHeight: 70,
                leading: const Icon(
                  Icons.pin_drop,
                  size: 30,
                  color: AppColors.yellow03,
                ),
                title: Text(address, style: const TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {},
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget addAddressButton(context) {
    return Container(
      color: AppColors.backgroundYellow,
      width: screen.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Add Address",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

  Widget spacer(height) => SizedBox(
        height: height,
      );
}
