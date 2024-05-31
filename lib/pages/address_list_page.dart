import 'package:donation_system/providers/provider_address_list.dart';
import 'package:donation_system/providers/provider_donors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';

class AppAddressListPage extends StatefulWidget {
  final dynamic user;
  final bool isDonor;
  const AppAddressListPage({super.key, required this.user, required this.isDonor});

  @override
  State<AppAddressListPage> createState() => _AppAddressesPagesState();
}

class _AppAddressesPagesState extends State<AppAddressListPage> {
  Stream<List<dynamic>> addresses = const Stream.empty();
  String user = "";

  @override
  void initState() {
    super.initState();
    // addresses = widget.isDonor ? widget.user.addressList : widget.user.orgAddressList;
    user = widget.isDonor ? "donors" : "organizations";
    context.read<AddressListProvider>().fetchAddress(user);
  }

  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    addresses = context.watch<AddressListProvider>().addressList;
    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.width,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: Column(
          children: [
            spacer(40.0),
            _buildHeader(),
            divider,
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: context.watch<AddressListProvider>().addressList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // or some other loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // or some other error indicator
                  } else {
                    List<dynamic> addresses = snapshot.data!;
                    return addresses.isEmpty ? noAddressWidget() : _buildList(addresses);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: addAddressButton(context),
    );
  }

  Widget noAddressWidget() {
    return Center(
      child: Container(
        color: AppColors.backgroundYellow,
        width: screen.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "No Address Found",
                style: TextStyle(color: AppColors.darkYellow01),
              ),
              TextButton(onPressed: addAddress, child: const Text("Add Address"))
            ],
          ),
        ),
      ),
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

  Widget _buildList(List<dynamic> addresses) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          itemCount: addresses.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade400,
          ),
          itemBuilder: ((context, index) {
            String address = addresses[index];
            return ListTile(
              minTileHeight: 60,
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
          onPressed: addAddress,
          child: const Text(
            "Add Address",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

  Future addAddress() {
    final TextEditingController addressController = TextEditingController();
    return showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              title: const Text("Add Address"),
              content: TextField(
                controller: addressController,
                decoration: const InputDecoration(hintText: "Enter Address"),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      context.read<AddressListProvider>().addAddress(user, addressController.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Add"))
              ],
            ));
  }

  Widget spacer(height) => SizedBox(
        height: height,
      );

  Widget get divider => Divider(
        color: Colors.grey.shade400,
      );
}
