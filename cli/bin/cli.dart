import 'package:cli/cli.dart' as cli;

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
void searchWikipedia(List<String>? arguments) {
  print("SearchWikipedia received arguments: $arguments");
}
