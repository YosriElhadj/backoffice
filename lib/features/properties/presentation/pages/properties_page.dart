import 'package:flutter/material.dart';
import '../../../dashboard/presentation/pages/admin_scaffold.dart';

class PropertiesPage extends StatefulWidget {
  @override
  _PropertiesPageState createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  // Sample property data
  final List<Map<String, dynamic>> _properties = [
    {
      'id': 'P001',
      'name': 'Sunset Valley Residence',
      'location': 'Phoenix, Arizona',
      'type': 'Residential',
      'investment': '\$2,500,000',
      'status': 'Active'
    },
    {
      'id': 'P002',
      'name': 'Green Acres Farm',
      'location': 'Riverside, California',
      'type': 'Agricultural',
      'investment': '\$1,200,000',
      'status': 'Pending'
    },
    {
      'id': 'P003',
      'name': 'Tech Campus Plot',
      'location': 'Austin, Texas',
      'type': 'Commercial',
      'investment': '\$5,800,000',
      'status': 'Active'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Property Management',
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
                  'All Properties',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add New Property'),
                  onPressed: () {
                    // TODO: Implement add property dialog
                    _showAddPropertyDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Properties Table
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
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Investment')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _properties.map((property) {
                      return DataRow(
                        cells: [
                          DataCell(Text(property['id'])),
                          DataCell(Text(property['name'])),
                          DataCell(Text(property['location'])),
                          DataCell(Text(property['type'])),
                          DataCell(Text(property['investment'])),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10, 
                                vertical: 5
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(property['status']),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                property['status'],
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
                                    // TODO: Implement edit property
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // TODO: Implement delete property
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

  void _showAddPropertyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Property'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Property Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                // Add more fields as needed
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
                // TODO: Implement add property logic
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}