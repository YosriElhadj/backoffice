import 'package:flutter/material.dart';
import '../../../dashboard/presentation/pages/admin_scaffold.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Sample user data
  final List<Map<String, dynamic>> _users = [
    {
      'id': 'U001',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'role': 'Investor',
      'status': 'Active'
    },
    {
      'id': 'U002',
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
      'role': 'Admin',
      'status': 'Active'
    },
    {
      'id': 'U003',
      'name': 'Mike Johnson',
      'email': 'mike.johnson@example.com',
      'role': 'Investor',
      'status': 'Pending'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'User Management',
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Users List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add New User'),
                  onPressed: () {
                    _showAddUserDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Users Table
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Role')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _users.map((user) {
                      return DataRow(
                        cells: [
                          DataCell(Text(user['id'])),
                          DataCell(Text(user['name'])),
                          DataCell(Text(user['email'])),
                          DataCell(Text(user['role'])),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10, 
                                vertical: 5
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(user['status']),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                user['status'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // TODO: Implement edit user
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // TODO: Implement delete user
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'User Role',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Investor', 'Admin', 'Analyst']
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // Handle role selection
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                // TODO: Implement add user logic
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}