import 'package:flutter/material.dart';
import 'package:in_class_sqfl/dbHelper.dart';
import 'prof.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'local sqfl example'),
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
  final dataBase = DBHelper.db;
  List<Prof> profs = [];
  TextEditingController profText = new TextEditingController();
  TextEditingController deptText = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Colors.greenAccent,
            ),
            tabs: const [
              Tab(text: "insert"),
              Tab(text: "update list"),
              Tab(text: "delete"),
              Tab(text: "Insert Info"),
              Tab(text: "Delete Info"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ElevatedButton(
              onPressed: () {
                _insert();
              },
              child: const Icon(Icons.app_registration_outlined, size: 125),
            ),
            Container(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: profs.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        '${profs[index].id} name: ${profs[index].name} '
                        'Dept: ${profs[index].department}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _delete();
              },
              child: const Icon(Icons.delete_forever, size: 125),
            ),
            Wrap(
              runSpacing: 80,
              alignment: WrapAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Professor Name",
                    labelText: "Professor Name",
                  ),
                  controller: profText,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Department Name",
                    labelText: "Department Name",
                  ),
                  controller: deptText,
                ),
                ElevatedButton(
                  onPressed: () {
                    String profName = profText.text;
                    String deptName = deptText.text;
                    _insertInfo(profName, deptName);
                    profText.clear();
                    deptText.clear();
                  },
                  child: const Icon(Icons.add_box_rounded, size: 125),
                ),
              ],
            ),
            Wrap(
              runSpacing: 80,
              alignment: WrapAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Professor Name",
                    labelText: "Professor Name",
                  ),
                  controller: profText,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Department Name",
                    labelText: "Department Name",
                  ),
                  controller: deptText,
                ),
                ElevatedButton(
                  onPressed: () {
                    String profName = profText.text;
                    String deptName = deptText.text;
                    _deleteInfo(profName, deptName);
                    profText.clear();
                    deptText.clear();
                  },
                  child: const Icon(Icons.delete_forever, size: 125),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _insert() async {
    Prof p = Prof(777, 'mark', 'CS');
    final id = await dataBase.insert(p);
    _updateList();
  }

  void _delete() async {
    int? val = profs[0].id;
    final rowsDeleted = await dataBase.delete(val!);
    _updateList();
  }

  void _insertInfo(String prof, String dept) async {
    Prof p = Prof(777, prof, dept);
    final id = await dataBase.insert(p);
    _updateList();
  }

  void _deleteInfo(String prof, String dept) async {
    final rowsDeleted = await dataBase.deleteInfo(prof, dept);
    _updateList();
  }

  void _updateList() async {
    final allRows = await dataBase.getRows();
    profs.clear();
    allRows?.forEach((row) => profs.add(Prof.fromJson(row)));
    setState(() {});
  }
}
