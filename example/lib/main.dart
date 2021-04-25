import 'package:flutter/material.dart';
import 'package:result_builder/result_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final resultList = Result<List<String>>(resultObject: <String>[]);

  @override
  void initState() {
    getLoadData();
    super.initState();
  }

  void getLoadData() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      resultList.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ResultBuilder(
          result: resultList,
          builderSuccessful: (() {
            if (resultList.resultObject.isEmpty) {
              return ResultErrorMessage("No items...");
            }
            return ListView.builder(
                itemCount: resultList.resultObject.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Text(resultList.resultObject[index]),
                  );
                });
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            setState(() {
              resultList.isLoading = true;
            });
            await Future.delayed(Duration(seconds: 1));
            setState(() {
              resultList.resultObject.add("Added item");
              resultList.resultStatus = true;
              resultList.isLoading = false;
            });
          }),
    );
  }
}
