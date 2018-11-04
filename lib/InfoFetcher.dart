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
    var text = "beef hot soup hotpot \"honeydew boba \"movie ticket \"concert \"rent \"toiletries \"hot sauce \"mayo \"green tea boba \"milk tea boba \"green tea boba \"green tea boba";
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
            .AUTHORIZATION: "Bearer eyJraWQiOiIyMDE3MTAzMC0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWE1M2I2NzkwLWE3OWUtNDE1ZS1hOTFkLWJhMmU1MmYwMWUzNCIsImlkIjoiaWFtLVNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJzdWIiOiJTZXJ2aWNlSWQtYTUzYjY3OTAtYTc5ZS00MTVlLWE5MWQtYmEyZTUyZjAxZTM0Iiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6bmF0dXJhbC1sYW5ndWFnZS11bmRlcnN0YW5kaW5nOnVzLXNvdXRoOmEvM2EyZTczMDdjZmNjNGVkNmE4ZTMyNTdhOTgxMmU5OGY6MWFlM2Y1YjktZTU5NC00YWIzLTkyM2YtNWUxZjRlYzgwZjllOjoiXSwiYWNjb3VudCI6eyJic3MiOiIzYTJlNzMwN2NmY2M0ZWQ2YThlMzI1N2E5ODEyZTk4ZiJ9LCJpYXQiOjE1NDEzMDA5NzEsImV4cCI6MTU0MTMwNDU3MSwiaXNzIjoiaHR0cHM6Ly9pYW0uYmx1ZW1peC5uZXQvaWRlbnRpdHkiLCJncmFudF90eXBlIjoidXJuOmlibTpwYXJhbXM6b2F1dGg6Z3JhbnQtdHlwZTphcGlrZXkiLCJzY29wZSI6ImlibSBvcGVuaWQiLCJjbGllbnRfaWQiOiJkZWZhdWx0IiwiYWNyIjoxLCJhbXIiOlsicHdkIl19.gkDJXmxCYcr_WHhaBGtZ7ntZJgKPo443D3Wp8p2f0lhpeilMpnSuv1vnmu7kTkgKsiOJ6e-hwzgRd6Z8LB125LI4oK-boNWKWWCb_hB5WFxxwmIsh-PG0aEx70iiJ7iugAoGgznRmoKffCGqxNiqhAsUmMi4ucGCf9m2TqynLwrgPY_GacJFZqp7UsV2pVO768BAnSgt0Pg1ssBc8YfKaVkAy2Pbd7FWlKGpOGJSpuoct4bmHcxnlp04vVJBIyCDumolnV1M472rsN6QkLdhzHrQIggIxGW_GdcB5yQfZXd9g0QqqC62uo9SHupx3ndrvEalrQ0WXMIWnE0KcYp-jw",
        HttpHeaders.CONTENT_TYPE: "application/json"
      },
      body: body
    );
    print(response.body);
    var result = json.decode(response.body.toString());
    _statusCode = response.statusCode;
    var categories = result["categories"];
    for (var category in categories) {
      _imageinfos.add(new ImageInformation(category["label"], category["score"]));
    }
    return _imageinfos;
  }
}