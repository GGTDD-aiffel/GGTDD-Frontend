import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/routing/app_routes.dart';
import 'package:provider/provider.dart';
import '../view_model/user_view_model.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserViewModel>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserViewModel>(context);

    if (viewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('User List')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (viewModel.users.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('User List')),
        body: Center(child: Text('No users found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: ListView.builder(
        itemCount: viewModel.users.length,
        itemBuilder: (context, index) {
          final user = viewModel.users[index];
          return ListTile(
            title: Text(user.name),
            onTap: () {
              Get.toNamed(AppRoutes.userDetail, arguments: user);
            },
          );
        },
      ),
    );
  }
}
