import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/admin/admin_org_detail_page.dart';
import 'package:donation_system/pages/org_details_page.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationsList extends StatefulWidget {
  final bool isAdmin;
  final bool isDonor;
  final bool isPage;
  const OrganizationsList(
      {required this.isPage, required this.isDonor, required this.isAdmin, super.key});

  @override
  State<OrganizationsList> createState() => _OrganizationsListState();
}

class _OrganizationsListState extends State<OrganizationsList> {
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
            spacer,
            _buildHeader(),
            _buildSearch(),
            _buildList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        !widget.isPage ? backButton : Container(),
        Text((!widget.isAdmin) ? "Choose an organization\nto donate to" : "Admin: Organizations",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: CustomWidgetDesigns.customTileContainer(),
      child: ListTile(
        title: const Text("Search for an Organization"),
        trailing: const Icon(Icons.search),
        onTap: () {
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => OrgDetailsPage(org: org)));
        },
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    Stream<QuerySnapshot> organizationStream = context.watch<OrganizationsProvider>().organization;
    return StreamBuilder<QuerySnapshot>(
      stream: organizationStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text("No Organizations Yet!"),
          );
        }

        var organizations = snapshot.data!.docs.map((doc) {
          return Organization.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: organizations.length,
              itemBuilder: ((context, index) {
                Organization organization = organizations[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: CustomWidgetDesigns.customTileContainer(),
                  child: ListTile(
                    leading: const Icon(
                      Icons.circle,
                      size: 50,
                      color: AppColors.yellow03,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organization.orgName ?? 'No Name',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@${organization.orgUsername}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: (!widget.isDonor)
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color:
                                  organization.orgStatus == 'Approved' ? Colors.green : Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              organization.orgStatus!.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (!widget.isAdmin)
                              ? OrgDetailsPage(organization: organization, isDonor: false)
                              : OrganizationDetailPage(organization: organization),
                        ),
                      );
                    },
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => OrgDetailsPage(
                    //                 org: org,
                    //                 isDonor: widget.isDonor,
                    //               )));
                    // },
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget get spacer => const SizedBox(height: 40);
}
