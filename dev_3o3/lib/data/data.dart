  // - Data
  class SearchData {
    final String collection;
    final String dateTime;
    final String displaySiteName;
    final String docUrl;
    final String imageUrl;
    final String thumbnailUrl;
    final int width;
    final int height;
    bool? isFavor;

    SearchData(
      {
        required this.collection,
        required this.dateTime,
        required this.displaySiteName,
        required this.docUrl,
        required this.imageUrl,
        required this.thumbnailUrl,
        required this.width,
        required this.height,
        this.isFavor,
      }
    );

    factory SearchData.fromJson(Map<String, dynamic> json) {
      return SearchData(
      collection: json['collection'] as String, 
      dateTime: json['datetime'] as String,
      displaySiteName: json['display_sitename'] as String, 
      docUrl: json['doc_url'] as String,
      imageUrl: json['image_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      isFavor: false,
      );
    }

    Map<String, dynamic> toJson() => {
      'collection' : collection,
      'datetime' : dateTime,
      'display_stiename' : displaySiteName,
      'doc_url' : docUrl,
      'image_url' : imageUrl,
      'thumbnail_url' : thumbnailUrl,
      'width' : width,
      'height' : height,
      'isFavor' : isFavor,
    };


}