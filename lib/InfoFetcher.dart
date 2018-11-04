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
    var url = "https://gateway.watsonplatform.net/natural-language-understanding/api/v1/analyze?version=2018-03-19";
    print(url);
    //var text = "I still have a dream. It is a dream deeply rooted in the American dream. I have a dream that one day this nation will rise up and live out the true meaning of its creed: \"We hold these truths to be self-evident, that all men are created equal.\"";
    var text = "beef hot soup hotpot \"honeydew boba \"movie";
    var body = json.encode(
        {"text": text,
          "features":
          {"categories": {}
          }
        });
    var response = await http.post(
      url,
      headers:
      {
        HttpHeaders
            .AUTHORIZATION: "Bearer eyJraWQiOiIyMDE3MTAzMC0wMDowMDowMCIsImFsZyI6IlJTMjU2In0.eyJpYW1faWQiOiJpYW0tU2VydmljZUlkLWE1M2I2NzkwLWE3OWUtNDE1ZS1hOTFkLWJhMmU1MmYwMWUzNCIsImlkIjoiaWFtLVNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJyZWFsbWlkIjoiaWFtIiwiaWRlbnRpZmllciI6IlNlcnZpY2VJZC1hNTNiNjc5MC1hNzllLTQxNWUtYTkxZC1iYTJlNTJmMDFlMzQiLCJzdWIiOiJTZXJ2aWNlSWQtYTUzYjY3OTAtYTc5ZS00MTVlLWE5MWQtYmEyZTUyZjAxZTM0Iiwic3ViX3R5cGUiOiJTZXJ2aWNlSWQiLCJ1bmlxdWVfaW5zdGFuY2VfY3JucyI6WyJjcm46djE6Ymx1ZW1peDpwdWJsaWM6bmF0dXJhbC1sYW5ndWFnZS11bmRlcnN0YW5kaW5nOnVzLXNvdXRoOmEvM2EyZTczMDdjZmNjNGVkNmE4ZTMyNTdhOTgxMmU5OGY6MWFlM2Y1YjktZTU5NC00YWIzLTkyM2YtNWUxZjRlYzgwZjllOjoiXSwiYWNjb3VudCI6eyJic3MiOiIzYTJlNzMwN2NmY2M0ZWQ2YThlMzI1N2E5ODEyZTk4ZiJ9LCJpYXQiOjE1NDEyOTcxMDMsImV4cCI6MTU0MTMwMDcwMywiaXNzIjoiaHR0cHM6Ly9pYW0uYmx1ZW1peC5uZXQvaWRlbnRpdHkiLCJncmFudF90eXBlIjoidXJuOmlibTpwYXJhbXM6b2F1dGg6Z3JhbnQtdHlwZTphcGlrZXkiLCJzY29wZSI6ImlibSBvcGVuaWQiLCJjbGllbnRfaWQiOiJkZWZhdWx0IiwiYWNyIjoxLCJhbXIiOlsicHdkIl19.Ds5UQX8WXiOYjtm5_X1BvQcxABnKIJFPkBolYK0XIhwThvcOaGe9wLiPNH_qnIwRiuNSPuBRgyxo2qiuvx1llALkhPWH8o5chnYam0P4SGGDtskDsKtlJs0NvUU2R_4JZtRf0p8O4_Xq22tLkznC9ttAXXtWvvHOO8ZmDdECcnI3kSey9fOZvt5uLXoHWM65GEzwIw-TlvruSv3gDA8SPnyUXiTfClXJBze-lXMnUZ_V1Uo4QopP1Qa-U_naN2GYO_TgiGGTV4WfCHi-oGI6CqKFmVlduddTpx7WxsLXgzk72Wz5yWxiJEOGvNx9HQWr2r6unAkljSMdWGqRFOYU6g",
        HttpHeaders.CONTENT_TYPE: "application/json"
      },
      body: body
    );
    print(response.body);
    _statusCode = response.statusCode;
    return null;
  }
}