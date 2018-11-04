import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:expense/ImageInformation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class InfoFetcher {
  Set<ImageInformation> _imageinfos;
  int _statusCode;

  InfoFetcher() {
    _statusCode = 0;
  }


  Set<ImageInformation> get imageinfos => _imageinfos;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<Set<ImageInformation>> fetchInfo() async {
    _imageinfos = new Set<ImageInformation>();
    var url = "https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19";
    print(url);
    final path = await _localPath;

    var response = await http.post(
      url,
      headers:
      {
        HttpHeaders
            .AUTHORIZATION: "Bearer eyJraWQiOiIyMDE3MTAzMC0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWMwNjcxZjk5LTcwNDQtNGEwYy1hZDI5LWI3ODY5ZjVjZTdmYSIsImlkIjoiaWFtLVNlcnZpY2VJZC1jMDY3MWY5OS03MDQ0LTRhMGMtYWQyOS1iNzg2OWY1Y2U3ZmEiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1jMDY3MWY5OS03MDQ0LTRhMGMtYWQyOS1iNzg2OWY1Y2U3ZmEiLCJzdWIiOiJTZXJ2aWNlSWQtYzA2NzFmOTktNzA0NC00YTBjLWFkMjktYjc4NjlmNWNlN2ZhIiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6d2F0c29uLXZpc2lvbi1jb21iaW5lZDp1cy1zb3V0aDphLzNhMmU3MzA3Y2ZjYzRlZDZhOGUzMjU3YTk4MTJlOThmOjE3ZTI4ZGE1LWIzYWYtNGJiMC04MWVjLWUxMzM0MmI3MDdjZDo6Il0sImFjY291bnQiOnsiYnNzIjoiM2EyZTczMDdjZmNjNGVkNmE4ZTMyNTdhOTgxMmU5OGYifSwiaWF0IjoxNTQxMjg2NTU4LCJleHAiOjE1NDEyOTAxNTgsImlzcyI6Imh0dHBzOi8vaWFtLmJsdWVtaXgubmV0L2lkZW50aXR5IiwiZ3JhbnRfdHlwZSI6InVybjppYm06cGFyYW1zOm9hdXRoOmdyYW50LXR5cGU6YXBpa2V5Iiwic2NvcGUiOiJpYm0gb3BlbmlkIiwiY2xpZW50X2lkIjoiZGVmYXVsdCIsImFjciI6MSwiYW1yIjpbInB3ZCJdfQ.Ypf-K5F1ymjYZFtf8g4fu8RV_okf8dG-hgAAHyOAaaMvg_zedukl2N8bsNjAsiPA_u4zN8uua4MQtpM2AFwq4bBdffgMKln2VfgMkdjTC6cFPkObdz2D6_Uc4bSfB1KqKmW-eFmJc75KSWP6k2EWHzyjIiTpB2ADdcGO_HJ1dlFWyBPmINtN7tP65eYZ8qkuy-vMFBRuC0OtkBRlkaRX7TeF4mTq-aDomIyLpWArZVEszJVX4WvQq4z_RSLrKQ2u4jnAlgNHGjbri9gUEGt38xvtCEH1E4P8eE1T4X6Z_6OB2_H0LQY6-Md6GQcR_Up_Dbx1LOENkNZDEyPvadrc7w"
      },
      body: {
        "images_file" : File('fruitbowl.jpg').readAsBytesSync()
        //"url": "https://www.w3schools.com/w3css/img_lights.jpg"
      }
    );
    print(response.body);
    _statusCode = response.statusCode;
    return null;
  }
}