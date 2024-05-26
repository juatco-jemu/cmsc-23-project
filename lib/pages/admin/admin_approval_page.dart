import 'package:donation_system/pages/org_list.dart';
import 'package:flutter/material.dart';

class AdminApprovalPage extends StatefulWidget {
  const AdminApprovalPage({super.key});

  @override
  State<AdminApprovalPage> createState() => _AdminApprovalPageState();
}

class _AdminApprovalPageState extends State<AdminApprovalPage> {
  final pendingOrgApproval = [];

  @override
  void initState() {
    //plavceholder for initialization of pendingOrgApproval
    super.initState();
    // pendingOrgApproval = context.read<OrganizationProvider>().pendingOrgApproval;
  }

  @override
  Widget build(BuildContext context) {
    if (pendingOrgApproval.isEmpty) {
      return const Center(
        child: Text("No pending organization approval"),
      );
    }

    return const OrganizationsList(isPage: true);
  }
}
