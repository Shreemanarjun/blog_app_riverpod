import 'package:blog_app_riverpod/data/models/blogs_model.dart';

abstract class HomeState {
  final BlogsModel blogmodel;
  const HomeState(this.blogmodel);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState && other.blogmodel == blogmodel;
  }

  @override
  int get hashCode => blogmodel.hashCode;
}

class HomeInitial extends HomeState {
  HomeInitial() : super(BlogsModel(blogs: []));
}

class HomeLoading extends HomeState {
  const HomeLoading(super.blogmodel);
}

class HomeLoaded extends HomeState {
  HomeLoaded(super.blogmodel);
}

class HomeRefreshing extends HomeState {
  HomeRefreshing(super.blogmodel);
}

class HomeRefreshError extends HomeState {
  const HomeRefreshError(super.blogmodel);
}

class HomeUnauthorized extends HomeState {
  HomeUnauthorized() : super(BlogsModel(blogs: []));
}

class HomeBlogDeleting extends HomeState {
  const HomeBlogDeleting(super.blogmodel);
}

class HomeBlogDeleted extends HomeState {
  const HomeBlogDeleted(super.blogmodel);
}

class HomeError extends HomeState {
  final String message;
  final String? details;
  HomeError({required this.message, required this.details})
      : super(BlogsModel(blogs: []));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeError &&
        other.message == message &&
        other.details == details;
  }

  @override
  int get hashCode => message.hashCode ^ details.hashCode;

  @override
  String toString() => 'HomeError(message: $message, details: $details)';
}

extension HomeStateUnion on HomeState {
  T map<T>({
    required T Function(HomeInitial) homeInitial,
    required T Function(HomeLoading) homeLoading,
    required T Function(HomeLoaded) homeLoaded,
    required T Function(HomeRefreshing) homeRefreshing,
    required T Function(HomeRefreshError) homeRefreshError,
    required T Function(HomeUnauthorized) homeUnauthorized,
    required T Function(HomeBlogDeleting) homeBlogDeleting,
    required T Function(HomeBlogDeleted) homeBlogDeleted,
    required T Function(HomeError) homeError,
  }) {
    if (this is HomeInitial) {
      return homeInitial(this as HomeInitial);
    }
    if (this is HomeLoading) {
      return homeLoading(this as HomeLoading);
    }
    if (this is HomeLoaded) {
      return homeLoaded(this as HomeLoaded);
    }
    if (this is HomeRefreshing) {
      return homeRefreshing(this as HomeRefreshing);
    }
    if (this is HomeRefreshError) {
      return homeRefreshError(this as HomeRefreshError);
    }
    if (this is HomeUnauthorized) {
      return homeUnauthorized(this as HomeUnauthorized);
    }
    if (this is HomeBlogDeleting) {
      return homeBlogDeleting(this as HomeBlogDeleting);
    }
    if (this is HomeBlogDeleted) {
      return homeBlogDeleted(this as HomeBlogDeleted);
    }
    if (this is HomeError) {
      return homeError(this as HomeError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}
