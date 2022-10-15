import 'package:adaptive_app/src/people.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity(horizontal: 4.0, vertical: 4.0)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return WideLayout();
          } else {
            return NarrowLayout();
          }
        },
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({Key? key}) : super(key: key);

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person? _person;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PeopleList(onPersonTap: (person) {
              setState(() => _person = person);
            }),
          ),
        ),
        Expanded(
          flex: 3,
          child:
              _person == null ? Placeholder() : PersonDetail(person: _person!),
        ),
      ],
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PeopleList(
      onPersonTap: (person) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: PersonDetail(person: person),
          ),
        ),
      ),
    ));
  }
}

class PeopleList extends StatelessWidget {
  const PeopleList({Key? key, required this.onPersonTap}) : super(key: key);

  final void Function(Person) onPersonTap;

  // const PeopleList({required this.onPersonTap})

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var person in people)
          ListTile(
            contentPadding: const EdgeInsets.all(5),
            leading: Image.network(person.picture),
            title: Text(person.name),
            onTap: () => onPersonTap(person),
          )
      ],
    );
  }
}

class PersonDetail extends StatelessWidget {
  const PersonDetail({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight > 200) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  child: Text(person.name),
                  onHover: (event) => print("object"),
                ),
                Text(person.phone),
                ElevatedButton(
                  child: const Text("Contact me"),
                  onPressed: () {},
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(person.name),
                Text(person.phone),
                ElevatedButton(
                  child: const Text("Contact me"),
                  onPressed: () {},
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
