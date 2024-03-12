abstract class SearchEvent {}

class SearchFetchDataEvent extends SearchEvent {}

class SearchAllMoviesEvent extends SearchEvent {}

class SearchQueryEvent extends SearchEvent {
  String query;

  SearchQueryEvent(this.query);
}
