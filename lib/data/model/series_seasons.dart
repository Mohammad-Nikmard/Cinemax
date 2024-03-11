class SeriesSeasons {
  String id;
  String collectionId;
  String season;
  String seriesTitle;
  String seriesId;

  SeriesSeasons(
      this.id, this.collectionId, this.season, this.seriesTitle, this.seriesId);

  factory SeriesSeasons.withJson(Map<String, dynamic> jsonMapObject) {
    return SeriesSeasons(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["season"],
      jsonMapObject["name"],
      jsonMapObject["series_id"],
    );
  }
}
