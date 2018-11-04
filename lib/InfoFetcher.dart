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

  Future<Set<ImageInformation>> fetchInfo() async {
    _imageinfos = new Set<ImageInformation>();
    var url = "https://gateway.watsonplatform.net/natural-language-understanding/api/v1/analyze?version=2018-03-19";
    print(url);
    //var text = "I still have a dream. It is a dream deeply rooted in the American dream. I have a dream that one day this nation will rise up and live out the true meaning of its creed: \"We hold these truths to be self-evident, that all men are created equal.\"";
    var text = "beef hot soup hotpot \"honeydew boba \"movie ticket \"concert \"rent \"toiletries \"hot sauce \"mayo \"green tea boba \"milk tea boba \"green tea boba \"green tea boba \"movie \"movie \"hulu subscription";
    var body = json.encode(
        {"text": text,
          "features":
          {"categories": {},
            "keywords":{}
          }
        });
    var response = await http.post(
      url,
      headers:
      {
        HttpHeaders
            .AUTHORIZATION: "Bearer eyJraWQiOiIyMDE3MTAzMC0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWE1M2I2NzkwLWE3OWUtNDE1ZS1hOTFkLWJhMmU1MmYwMWUzNCIsImlkIjoiaWFtLVNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJzdWIiOiJTZXJ2aWNlSWQtYTUzYjY3OTAtYTc5ZS00MTVlLWE5MWQtYmEyZTUyZjAxZTM0Iiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6bmF0dXJhbC1sYW5ndWFnZS11bmRlcnN0YW5kaW5nOnVzLXNvdXRoOmEvM2EyZTczMDdjZmNjNGVkNmE4ZTMyNTdhOTgxMmU5OGY6MWFlM2Y1YjktZTU5NC00YWIzLTkyM2YtNWUxZjRlYzgwZjllOjoiXSwiYWNjb3VudCI6eyJic3MiOiIzYTJlNzMwN2NmY2M0ZWQ2YThlMzI1N2E5ODEyZTk4ZiJ9LCJpYXQiOjE1NDEzMTQ3NjIsImV4cCI6MTU0MTMxODM2MiwiaXNzIjoiaHR0cHM6Ly9pYW0uYmx1ZW1peC5uZXQvaWRlbnRpdHkiLCJncmFudF90eXBlIjoidXJuOmlibTpwYXJhbXM6b2F1dGg6Z3JhbnQtdHlwZTphcGlrZXkiLCJzY29wZSI6ImlibSBvcGVuaWQiLCJjbGllbnRfaWQiOiJkZWZhdWx0IiwiYWNyIjoxLCJhbXIiOlsicHdkIl19.WvijO2GDh02_G8J03Twr59Hg9BFUO-GweIyD2l1DpHzLaH7ic7yUYj5aaGoOpbHp5bcft0Pmvm3Bbdr4lEBM6S_7fQi9L0a7NlkXHBOmAE9CsMlBq19iysPI7V8Z_KOZva5iijwEpv73WUOc5-4HmEw2WK42zgtgseknggFdyQKeLeqd__Lp6OsKJfed-2A5SCfU1ycCCkaacH1TcKl4S0j4SRUwABO4p58qQSBltfoZIEeyjgt8yv3qyWzyGYuroWq43eDA0tXUNRbYDXYj6eE-l1IBt0Wg4UNBixnVN4V5ebJYZyAx0iHUUV-A73AutH0NSmbUTarc_YeU2V5b8g",
        HttpHeaders.CONTENT_TYPE: "application/json"
      },
      body: body
    );
    print(response.body);
    var result = json.decode(response.body.toString());
    _statusCode = response.statusCode;
    var categories = result["categories"];
    for (var category in categories) {
      _imageinfos.add(new ImageInformation(category: category["label"], score: category["score"]));
    }
    return _imageinfos;
  }
}