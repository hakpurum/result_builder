import 'package:flutter/material.dart';

class Result<T> {
  String resultMessage;
  bool resultStatus;
  T resultObject;
  String resultTrackingCode;
  bool isLoading = true;

  Result({this.resultStatus = true});
}

class ResultErrorMessage extends StatelessWidget {
  final String resultMessage;

  ResultErrorMessage(this.resultMessage);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.error,
                color: Colors.red[900],
                size: 50.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(resultMessage,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red[900]),),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultBuilder<T> extends StatelessWidget {
  final Function builderSuccessful;
  final Function builderUnSuccessful;
  final Result<T> result;

  ResultBuilder(
      {
        this.builderSuccessful,
        this.builderUnSuccessful,
        this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return Container(
        child: ResultErrorMessage("result parameter cannot be null!"),
      );
    } else if (builderSuccessful == null) {
      return Container(
        child: ResultErrorMessage("builder parameter cannot be null!"),
      );
    }

    if (result.isLoading) {
      return Container(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (result.resultStatus) {
        return builderSuccessful();
      } else {
        if (builderUnSuccessful == null) {
          return Container(
            child: ResultErrorMessage(result.resultMessage),
          );
        } else {
          return builderUnSuccessful();
        }
      }
    }
  }
}