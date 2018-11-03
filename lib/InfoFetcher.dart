import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:expense/ImageInformation.dart';

class InfoFetcher {
  Set<ImageInformation> _imageinfos;
  int _statusCode;

  InfoFetcher() {
    _statusCode = 0;
  }


  Set<ImageInformation> get imageinfos => _imageinfos;

  Future<Set<ImageInformation>> fetchInfo() async {
    _imageinfos = new Set<ImageInformation>();
    var url = "https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19";
    print(url);
    var response = await http.post(
      url,
      headers:
      {
        HttpHeaders
            .AUTHORIZATION: "Bearer eyJraWQiOiIyMDE3MTAzMC0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWMwNjcxZjk5LTcwNDQtNGEwYy1hZDI5LWI3ODY5ZjVjZTdmYSIsImlkIjoiaWFtLVNlcnZpY2VJZC1jMDY3MWY5OS03MDQ0LTRhMGMtYWQyOS1iNzg2OWY1Y2U3ZmEiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1jMDY3MWY5OS03MDQ0LTRhMGMtYWQyOS1iNzg2OWY1Y2U3ZmEiLCJzdWIiOiJTZXJ2aWNlSWQtYzA2NzFmOTktNzA0NC00YTBjLWFkMjktYjc4NjlmNWNlN2ZhIiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6d2F0c29uLXZpc2lvbi1jb21iaW5lZDp1cy1zb3V0aDphLzNhMmU3MzA3Y2ZjYzRlZDZhOGUzMjU3YTk4MTJlOThmOjE3ZTI4ZGE1LWIzYWYtNGJiMC04MWVjLWUxMzM0MmI3MDdjZDo6Il0sImFjY291bnQiOnsiYnNzIjoiM2EyZTczMDdjZmNjNGVkNmE4ZTMyNTdhOTgxMmU5OGYifSwiaWF0IjoxNTQxMjgyMjg4LCJleHAiOjE1NDEyODU4ODgsImlzcyI6Imh0dHBzOi8vaWFtLmJsdWVtaXgubmV0L2lkZW50aXR5IiwiZ3JhbnRfdHlwZSI6InVybjppYm06cGFyYW1zOm9hdXRoOmdyYW50LXR5cGU6YXBpa2V5Iiwic2NvcGUiOiJpYm0gb3BlbmlkIiwiY2xpZW50X2lkIjoiZGVmYXVsdCIsImFjciI6MSwiYW1yIjpbInB3ZCJdfQ.KkcSYGsKJhlkErqqMgffdrxiapjJ6fESe7Iu7aknJlzP-yiLCn8rTpqcDcC3hSJDDhu_pIuJsUyLwakUpv3_c4uyk3WuEYulFga7BCr8BpGN2yUx0us9eISHmf0BDoahOFsWhS3fi22CqQZdPmSJAuYkqwBZzg0lftSdRRQVKjAXxTDu1IucTvMgsJj36n858KHblrSrCMB3j-SiRT6A-s3LhG4myrKcjIr_T2fkSo87BzYausQAUJL8pswR-j-B-ZvpNpmJKn8M4bejW1RLHevXM0AiyYHQVnf95KoOiZjfcrJOYnws9o4tX9ZRUp891BFcYW8g6FMx01Jsd5RmQA"
      },
      body: {
        "imagesFilename": "fruitbowl.jpg",
        "imagesFile": AssetImage("fruitbowl.jpg")
      }
    );
    print(response.body);
    _statusCode = response.statusCode;
    return null;
  }
}