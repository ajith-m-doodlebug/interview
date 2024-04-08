class GifsResponseClass {
  final List<String> gifUrls;
  final int total;

  GifsResponseClass({required this.total, required this.gifUrls});

  factory GifsResponseClass.fromJson(Map<String, dynamic> json) {
    List<dynamic> fetchedData = json["data"];

    List<String> parsedUrls = fetchedData
        .map((item) => item["images"]["original"]["url"].toString())
        .toList();

    return GifsResponseClass(
      gifUrls: parsedUrls,
      total: json["pagination"]["total_count"],
    );
  }
}
