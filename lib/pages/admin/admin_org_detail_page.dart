import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationDetailPage extends StatefulWidget {
  final Organization organization;

  const OrganizationDetailPage({Key? key, required this.organization}) : super(key: key);

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  String? _status;

  @override
  void initState() {
    super.initState();
    _status = widget.organization.orgStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.organization.orgName ?? 'Organization Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.organization.orgName ?? 'No Name'}'),
            Text('Username: ${widget.organization.orgUsername ?? 'No Username'}'),
            Text('Email: ${widget.organization.orgEmail ?? 'No Email'}'),
            Text('Description: ${widget.organization.orgDescription ?? 'No Description'}'),
            Text('Address List: ${widget.organization.orgAddressList?.join(', ') ?? 'No Addresses'}'),
            Text('Contact Number: ${widget.organization.orgContactNumber ?? 'No Contact Number'}'),
            Text('Status: ${_status ?? 'No Status'}'),
            const SizedBox(height: 20),
            Text('Change Status:'),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _updateStatus('Approved'),
                  child: const Text('Approve'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _updateStatus('Rejected'),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateStatus(String status) async {
    try {
      context.read<OrganizationsProvider>().updateOrganizationStatus(widget.organization.orgUsername!, status);
      setState(() {
        _status = status;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $status')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $error')),
      );
    }
  }
}

