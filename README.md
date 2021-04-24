# result_builder
It is a structure that allows the study of the result sets to be generically listened for each type.

## Getting Started

To use this plugin, add `result_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## main.dart setState ListView Example

```dart  
import 'package:flutter/material.dart';
import 'package:result_builder/result_builder.dart';

class _MyHomePageState extends State<MyHomePage> {
  final resultList = Result<List<String>>();

  @override
  void initState() {
    getLoadData();
    super.initState();
  }

  void getLoadData() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      resultList.isLoading = true;
      resultList.resultObject = <String>[];
      resultList.resultStatus = true;
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
            if(resultList.resultObject.isEmpty){
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
```

## main.dart setState Form Example

```dart
import 'package:flutter/material.dart';
import 'package:result_builder/result_builder.dart';

class _MyHomePageState extends State<MyHomePage> {
  final resultList = Result<bool>();

  @override
  void initState() {
    pageLoad();
    super.initState();
  }

  void pageLoad() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      resultList.resultObject = false;
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
            return SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                child: Column(
                  children: [
                    Text("Username"),
                    TextField(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(resultList.resultMessage,style: TextStyle(fontSize: 20,color:Colors.green,fontWeight: FontWeight.bold),),
                    ),
                    MaterialButton(
                        color: Colors.blue,
                        splashColor: Colors.white,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Login",style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          setState(() {
                            resultList.isLoading = true;
                          });
                          await Future.delayed(Duration(seconds: 1));
                          setState(() {
                            resultList.resultObject = true;
                            resultList.resultMessage = "Login Success.";
                            resultList.resultStatus = true;
                            resultList.isLoading = false;
                          });
                        })
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
```

