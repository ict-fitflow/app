import 'package:fitflow/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _compact_view = true;
  bool _dark_mode = false;
  bool _daily_goals = true;

  late SettingsProvider usersettings;

  @override
  void initState() {
    super.initState();
    usersettings = context.read<SettingsProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return ListView(
          children: [
            Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://i.guim.co.uk/img/media/8dd989f70bc471a8dd2970d87c5338501bb88af1/142_217_3250_1951/master/3250.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=98149160ba44c2da042cd76503c05c40'
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mario Rossi",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Member since 2023",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 4
                ),
                child: Text(
                  "UI",
                  style: Theme.of(context).textTheme.headlineSmall,
                )
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark theme"),
              trailing: Switch(
                  value: settings.darkTheme,
                  onChanged: _toggle_dark_mode
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text("Compact view"),
              trailing: Switch(
                  value: _compact_view,
                  onChanged: _toggle_compact_view
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 4
                ),
                child: Text(
                  "Daily goals",
                  style: Theme.of(context).textTheme.headlineSmall,
                )
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Enable daily goal"),
              trailing: Switch(
                  value: _daily_goals,
                  onChanged: _toggle_enable_goals
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit goals"),
              onTap: _edit_daily_goals,
              enabled: _daily_goals,
            )
          ],
        );
      }
    );
  }

  void _toggle_enable_goals(bool value) {
    setState(() {
      _daily_goals = value;
    });
  }

  void _edit_daily_goals() {
    throw UnimplementedError("Edit daily goals");
  }

  void _toggle_compact_view(bool value) {
    setState(() {
      _compact_view = value;
    });
  }

  void _toggle_dark_mode(bool value) {
    usersettings.darkTheme = value;
  }
}
