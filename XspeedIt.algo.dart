List<List<int>> box = [];
List<int> articlesList = [];
void main(List<String> args) {
  if (args.isNotEmpty && RegExp(r'^[0-9]+$').hasMatch(args[0])) {
    xspeedltAlgo(args[0]);
  } else {
    printUsage();
  }
}

xspeedltAlgo(articles) {
  for (int i = 0; i < articles.length; i++) {
    articlesList.add(int.parse(articles[i]));
  }
  articlesList.sort((a, b) => b.compareTo(a));
  articlesList.forEach((article) {
    var hasBeenStored = putInBox(article, box);
    if (!hasBeenStored) createBox(article, box);
  });
  displayBoxContent(box);
}

bool putInBox(int article, List<List<int>> boxList) {
  for (int i = 0; i < boxList.length; i++) {
    int sizeOfBox =
        boxList[i].fold(0, (previousValue, element) => previousValue + element);
    if (sizeOfBox + article <= 10) {
      boxList[i].add(article);
      return true;
    }
  }
  return false;
}

void createBox(int article, List<List<int>> boxList) {
  boxList.add([article]);
}

void displayBoxContent(List<List<int>> boxList) {
  String result = boxList.map((list) => list.join('')).join('/');
  print(result);
}

void printUsage() {
  print('''

      Usage : dart XspeedIt.algo.dart [ArticleList]
        ArticleList: is a string of int
    ''');
}
