import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String bookTitle;
  final String requestedBy;
  final String requestStatus;
  final String? reason;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const RequestCard({super.key, 
    required this.bookTitle,
    required this.requestedBy,
    required this.requestStatus,
    this.reason,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book: $bookTitle',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Requested by: $requestedBy',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Status: $requestStatus',
              style: TextStyle(
                fontSize: 14,
                color: requestStatus == 'Approved' ? Colors.green : Colors.red,
              ),
            ),
            if (requestStatus == 'Rejected' && reason != null)
              Text(
                'Reason: $reason',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onApprove,
                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                  child: Text('Approve'),
                ),
                TextButton(
                  onPressed: onReject,
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: Text('Reject'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
