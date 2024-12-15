import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'appwrite_provider.dart';

class UpdateDeletePage extends StatefulWidget {
  @override
  _UpdateDeletePageState createState() => _UpdateDeletePageState();
}

class _UpdateDeletePageState extends State<UpdateDeletePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _fetchUserDetails(); // Fetch user details on page load
  }

  Future<void> _fetchUserDetails() async {
    try {
      // Fetch user details
      final user = await appwriteProvider.account.get();

      setState(() {
        _nameController.text = user.name; // Use the 'name' getter
        _emailController.text = user.email; // Use the 'email' getter
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: ${e.toString()}')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _updateUserDetails() async {
    try {
      await appwriteProvider.account.updateName(
        name: _nameController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User details updated successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating user: ${e.toString()}')));
    }
  }

  Future<void> _deleteUser() async {
    try {
      await appwriteProvider.account.delete();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account deleted successfully!')));

      Navigator.pop(context); // Navigate back after account deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting account: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Update/Delete Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              readOnly: true, // Email should not be editable
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _updateUserDetails,
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: _deleteUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on Account {
  delete() {}
}
