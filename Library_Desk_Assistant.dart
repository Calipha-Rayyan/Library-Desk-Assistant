//       Library Desk Assistant
// Name: Muhammad Rayyan Bhatti
// Roll No: 04072312024

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// ============================================================
// PART 1 FUNCTIONS
// ============================================================

// Task 1.1: Positional parameters
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

// Task 1.2: Optional positional parameter
String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }
  return '$title by $author';
}

// Task 1.3: Named parameters with required and default values
Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

// Task 1.4: Arrow function
bool isClassic(int year) => year < 2000;

// ============================================================
// PART 2 FUNCTIONS
// ============================================================

// Task 2.1: Higher-order function
List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}

// Task 2.2: Closure
int Function() makeCounter() {
  int count = 0;

  return () {
    count++;
    return count;
  };
}

// Task 2.3: Closure with parameter
double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

// Task 2.4: Recursion
int sumDigits(int n) {
  if (n < 10) {
    return n;
  }

  return (n % 10) + sumDigits(n ~/ 10);
}

// ============================================================
// PART 3 FUNCTIONS
// ============================================================

// Task 3.4: Build stock map
Map<String, int> buildStock() {
  return {
    for (var book in books) book['title'] as String: book['copies'] as int,
  };
}

// ============================================================
// PART 4 GENERICS
// ============================================================

// Task 4.1: Generic class
class Box<T> {
  T value;

  Box(this.value);
}

// Task 4.2: Generic function
T firstOr<T>(List<T> items, T fallback) {
  if (items.isNotEmpty) {
    return items.first;
  }

  return fallback;
}

// Task 4.3: Generic class with two type parameters
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}

// ============================================================
// PART 5 ERROR HANDLING
// ============================================================

// Custom exception 1
class BookNotFoundException implements Exception {
  final String title;

  BookNotFoundException(this.title);
}

// Custom exception 2
class BookNotAvailableException implements Exception {
  final String title;

  BookNotAvailableException(this.title);
}

// Task 5.2: Check out a book
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }

  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }

  stock[title] = stock[title]! - 1;
}

// Task 5.4: Find a book
Map<String, dynamic> findBook(String title) {
  return books.firstWhere((book) => book['title'] == title);
}

// ============================================================
// PART 6 ASYNC FUNCTIONS
// ============================================================

// Task 6.1: Future
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Dart in Action';
}

// Task 6.3: Future with error
Future<String> fetchBroken() async {
  await Future.delayed(const Duration(milliseconds: 500));
  throw Exception('Server down');
}

// ============================================================
// MAIN
// ============================================================

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

// ============================================================
// PART 1
// ============================================================

void part1() {
  print('--- Part 1 ---');

  print('Late fee: ${lateFee(5, 0.5)}');

  print(formatTitle('Dart in Action'));

  print(formatTitle('Dart in Action', 'Ada'));

  print(makeBook(title: 'Clean Code', author: 'Martin'));

  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));

  print(isClassic(1968));

  print(isClassic(2021));
}

// ============================================================
// PART 2
// ============================================================

void part2() {
  print('--- Part 2 ---');

  final items = ['Dart in Action', 'Clean Code'];

  final upperCase = transformAll(items, (item) => item.toUpperCase());

  final withExclamation = transformAll(items, (item) => '$item!');

  print(upperCase);
  print(withExclamation);

  final desk1 = makeCounter();
  final desk2 = makeCounter();

  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  final studentFee = makeFeeCalculator(0.25);
  final staffFee = makeFeeCalculator(0.10);

  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(1235)}');
}

// ============================================================
// PART 3
// ============================================================

void part3() {
  print('--- Part 3 ---');

  // Task 3.1: map and where
  final titles = books.map((book) => book['title'] as String).toList();

  final available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();

  print('Titles: $titles');
  print('Available: $available');

  // Task 3.2: fold and reduce
  final totalCopies = books.fold<int>(
    0,
    (sum, book) => sum + (book['copies'] as int),
  );

  final years = books.map((book) => book['year'] as int).toList();

  final oldestYear = years.reduce((a, b) => a < b ? a : b);

  print('Total copies: $totalCopies');
  print('Oldest year: $oldestYear');

  // Task 3.3: Sort a copy, not the original list
  final sortedBooks = [...books];

  sortedBooks.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));

  final byYear = sortedBooks.map((book) => book['title'] as String).toList();

  print('By year: $byYear');

  // Task 3.4: Map
  final stock = buildStock();

  print('Stock: $stock');

  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  // Task 3.5: Set
  final allTags = {for (var book in books) ...(book['tags'] as List<String>)};

  print('All tags: $allTags');

  final a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};

  final b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

// ============================================================
// PART 4
// ============================================================

void part4() {
  print('--- Part 4 ---');

  final intBox = Box<int>(5);
  final stringBox = Box<String>('dart');

  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');

  // This produces a compile-time error, so it must remain commented.
  // intBox.value = 'hello';

  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));

  print(firstOr<String>([], 'z'));

  print(Pair<String, int>('Dart in Action', 3));
}

// ============================================================
// PART 5
// ============================================================

void part5() {
  print('--- Part 5 ---');

  final stock = buildStock();

  final titles = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];

  for (final title in titles) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

// ============================================================
// PART 6
// ============================================================

Future<void> part6() async {
  print('--- Part 6 ---');

  print('Fetching...');

  final book = await fetchBookOfTheDay();

  print('Book of the day: $book');

  try {
    final result = await fetchBroken();
    print(result);
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// ============================================================
// REFLECTION
// ============================================================

// 1. fold vs reduce:
// I would choose fold when I need a starting value or when the list
// might be empty. reduce requires at least one element.

// 2. Closure:
// A closure captures a variable when the returned function remembers
// and can access that variable even after the outer function finishes.
// In makeCounter, the variable captured is count.

// 3. Exception order:
// BookNotAvailableException should be handled before a general catch
// because specific exception handling should happen before general handling.

// 4. await:
// Forgetting await still compiles because a Future is a valid value.
// However, it gives a Future object instead of the actual result.
