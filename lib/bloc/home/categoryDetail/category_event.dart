abstract class CategoryEvent {}

class CategoryFetchEvent extends CategoryEvent {
  String category;

  CategoryFetchEvent(this.category);
}
