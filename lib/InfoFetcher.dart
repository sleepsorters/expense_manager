import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:expense/ImageInformation.dart';
import 'package:expense/Keyword.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class InfoFetcher {
  Set<ImageInformation> _imageinfos;
  Set<Keyword> _keywords;
  var _result;
  int _statusCode;
  String str;

  InfoFetcher() {
    _statusCode = 0;
  }


  Set<ImageInformation> get imageinfos => _imageinfos;
  Set<Keyword> get keywords => _keywords;

  Future<Set<ImageInformation>> fetchInfo(String expenseListString) async {
    _imageinfos = new Set<ImageInformation>();
    var url = "https://gateway.watsonplatform.net/natural-language-understanding/api/v1/analyze?version=2018-03-19";
    print(url);
    //var text = "I still have a dream. It is a dream deeply rooted in the American dream. I have a dream that one day this nation will rise up and live out the true meaning of its creed: \"We hold these truths to be self-evident, that all men are created equal.\"";
    var text = expenseListString;
    var body = json.encode(
        {"text": text,
          "features":
          {"categories": {},
            "keywords": {}
          }
        });
    var response = await http.post(
        url,
        headers:
        {
          HttpHeaders
              .AUTHORIZATION: "Bearer eyJraWQiOiIyMDE3MTAzMC0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWE1M2I2NzkwLWE3OWUtNDE1ZS1hOTFkLWJhMmU1MmYwMWUzNCIsImlkIjoiaWFtLVNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJzdWIiOiJTZXJ2aWNlSWQtYTUzYjY3OTAtYTc5ZS00MTVlLWE5MWQtYmEyZTUyZjAxZTM0Iiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6bmF0dXJhbC1sYW5ndWFnZS11bmRlcnN0YW5kaW5nOnVzLXNvdXRoOmEvM2EyZTczMDdjZmNjNGVkNmE4ZTMyNTdhOTgxMmU5OGY6MWFlM2Y1YjktZTU5NC00YWIzLTkyM2YtNWUxZjRlYzgwZjllOjoiXSwiYWNjb3VudCI6eyJic3MiOiIzYTJlNzMwN2NmY2M0ZWQ2YThlMzI1N2E5ODEyZTk4ZiJ9LCJpYXQiOjE1NDEzMzA3MzMsImV4cCI6MTU0MTMzNDMzMywiaXNzIjoiaHR0cHM6Ly9pYW0uYmx1ZW1peC5uZXQvaWRlbnRpdHkiLCJncmFudF90eXBlIjoidXJuOmlibTpwYXJhbXM6b2F1dGg6Z3JhbnQtdHlwZTphcGlrZXkiLCJzY29wZSI6ImlibSBvcGVuaWQiLCJjbGllbnRfaWQiOiJkZWZhdWx0IiwiYWNyIjoxLCJhbXIiOlsicHdkIl19.AMAB4EV_FzQywlAavICV86V5aPBMK513Sp6OeQLvWsMCAQQI84S3Q7RzEM2r5ZJjjihjk78Fr2EP6eJgXDHNy5pYPH7c7M1WbVS1Yvbkkbzorlb4qxYSvHU_eo3luvPnzkZuxDaHOeM1iNsCQ5PohFGGHpGDZh53foQ8fEfMG6eUmpS_YyxnryGeMdRGCZSy3IF4cXpf_GbPU7vSkTDgbvlcpXKcYtlTtWZXNH3QpWio1bzwkLQozh7aGAKk0ZTtjbtpBO-61CYnq1-dyDKK1J185fZX8yUQVURnX1xCCs0915bA-zlDAMN7D0DCX2uNnHhaSADI054253lIUBkn6w",
          HttpHeaders.CONTENT_TYPE: "application/json"
        },
        body: body
    );
    print(response.body);
    _result = json.decode(response.body.toString());
    _statusCode = response.statusCode;
    var categories = _result["categories"];
    for (var category in categories) {
      _imageinfos.add(new ImageInformation(
          category: category["label"], score: category["score"]));
    }
    return _imageinfos;
  }

  Future<Set<Keyword>> fetchKeywords() async {
    _keywords = new Set<Keyword>();
    var keywords = _result["keywords"];
    for (var keyword in keywords) {
      _keywords.add(new Keyword(
          word: keyword["text"], relevance: keyword["relevance"]));
    }
    return _keywords;
  }
}