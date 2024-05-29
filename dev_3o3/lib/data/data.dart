  // - Data
  class SearchData {
    final String collection;
    final String dateTime;
    final String displayStieName;
    final String docUrl;
    final String imageUrl;
    final String thumbnailUrl;
    final int width;
    final int height;

    SearchData(
      {
        required this.collection,
        required this.dateTime,
        required this.displayStieName,
        required this.docUrl,
        required this.imageUrl,
        required this.thumbnailUrl,
        required this.width,
        required this.height,
      }
    );

    factory SearchData.fromJson(Map<String, dynamic> json) {
      return SearchData(
      collection: json['collection'] as String, 
      dateTime: json['datetime'] as String,
      displayStieName: json['display_sitename'] as String, 
      docUrl: json['doc_url'] as String,
      imageUrl: json['image_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );
    
  }
}