import 'package:flutter/material.dart';
import 'package:plan_task/providers/settings_provider.dart';
import 'package:plan_task/providers/task_list_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Consumer<SettingsProvider>(
            builder: (context, settings, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SwitchListTile(
                  title: const Text('Show Done Tasks'),
                  value: settings.showDoneTasks,
                  onChanged: (value) {
                    settings.toggleShowDoneTasks();
                  },
                ),
              );
            },
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
              ),
              onPressed: () {
                // This action is not an actual setting and therefore
                // doesn't need to be in the SettingsProvider
                Provider.of<TaskListProvider>(context, listen: false)
                    .clearDoneTasks();
                Navigator.pop(context);
              },
              child: const Text('Clear Done Tasks'),
            ),
          ),
        ],
      ),
    );
  }
}
