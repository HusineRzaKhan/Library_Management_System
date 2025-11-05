import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewRequestsScreen extends StatelessWidget {
  const ViewRequestsScreen({super.key});

  Future<void> approveRequest(
      String requestId, Map<String, dynamic> bookDetails) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(requestId)
        .update({
      'status': 'approved',
      'book_details': bookDetails,
    });
  }

  Future<void> rejectRequest(String requestId, String reason) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(requestId)
        .update({
      'status': 'rejected',
      'reason': reason,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Requests'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return ListTile(
                title: Text(request['title']),
                subtitle: Text('Requested by: ${request['student_id']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        approveRequest(request.id, request['book_details']);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        rejectRequest(request.id, 'Not available');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
