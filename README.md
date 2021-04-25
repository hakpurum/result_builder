# result_builder
It is a structure that allows the study of the result sets to be generically listened for each type.

## Getting Started

To use this plugin, add `result_builder` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

<img src="https://raw.githubusercontent.com/hakpurum/result_builder/main/onboard_list.gif" alt="flutter_onboard" width="250" style="max-width: 25%;">

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

<img src="https://raw.githubusercontent.com/hakpurum/result_builder/main/onboard_form.gif" alt="flutter_onboard" width="250" style="max-width: 25%;">

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

## main.dart Getx Form Example
```dart
import 'package:flutter/material.dart';
import 'package:result_builder/result_builder.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class LoginController extends GetxController {
  final resultList = Result<bool>().obs;

  @override
  void onInit() {
    pageLoad();
    super.onInit();
  }

  void pageLoad() async {
    var model = Result<bool>();
    await Future.delayed(Duration(seconds: 2));
    model.resultObject = false;
    model.isLoading = false;
    resultList(model);
  }

  void login() {
    resultList(Result<bool>());
    Future.delayed(Duration(seconds: 2)).then((value) => loginMethod());
  }

  loginMethod() {
    var model = Result<bool>();
    model.resultObject = true;
    model.resultMessage = "Login Success.";
    model.resultStatus = true;
    model.isLoading = false;
    resultList(model);
  }
}

class MyApp extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demo Home Page"),
        ),
        body: Center(
          child: buildBody(),
        ),
      ),
    );
  }

  buildBody() {
    return Obx((){
      var result = loginController.resultList.value;
      return ResultBuilder(
        result: result,
        builderSuccessful: (() {
          return SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Username"),
                  TextField(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result.resultMessage,style: TextStyle(fontSize: 20,color:Colors.green,fontWeight: FontWeight.bold),),
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      splashColor: Colors.white,
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Login",style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        _formKey.currentState.save();
                        loginController.login();
                      })
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}

```