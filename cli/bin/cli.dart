import 'package:cli/cli.dart' as cli;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

const version = "0.0.1";

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == "version") {
    print("Dartpedia CLI version $version");
  } else if (arguments.first == "search") {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

//List<String>? arguments means arguments list itself can be null
void searchWikipedia(List<String>? arguments) async {
  final String? articleTitle; //wom7t be null

  //if the user did not pass an argument, send request
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    // await input, provide empty string if input is null
    articleTitle = stdin.readLineSync() ?? ""; //read input
    //??: null-coalescing operator, used as fallback in null cases
  } else {
    //join argumnents into single string
    articleTitle = arguments.join("");
  }
  print("Looking up articles about $articleTitle. Please wait");

  //Call API
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent); //raw json
}

//Future: relevant to Promise, produce a String result in asynchronous
Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org', //authority - wikipedia domain
    '/api/rest_v1/page/summary/$articleTitle', //unencoded path,
  );

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Error: Failed to fetch article: "$articleTitle". Status code: "${response.statusCode}"';
}
