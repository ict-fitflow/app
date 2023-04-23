import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
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
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Andrea Dipace",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "bla bla bla",
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
          title: const Text("Tema scuro"),
          trailing: Switch(
              value: false,
              onChanged: (bool t) => print('changed')
          ),
        ),
        ListTile(
          leading: const Icon(Icons.list_alt),
          title: const Text("bla bla bla"),
          trailing: Switch(
              value: false,
              onChanged: (bool t) => print('changed')
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
          leading: const Icon(Icons.list_alt),
          title: const Text("bla bla bla"),
          trailing: Switch(
              value: true,
              onChanged: (bool t) => print('changed')
          ),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text("bla bla bla"),
          onTap: () => print('changed'),
        )
      ],
    );
  }
}
