abstract class UpdateBlogState {
  const UpdateBlogState();
}

class BlogUpdateInitial extends UpdateBlogState {
  const BlogUpdateInitial();
}

class BlogUpdating extends UpdateBlogState {
  const BlogUpdating();
}

class BlogUpdated extends UpdateBlogState {
  const BlogUpdated();
}

class BlogUpdateError extends UpdateBlogState {
  const BlogUpdateError();
}

class UnAuthorizedError extends UpdateBlogState {
  const UnAuthorizedError();
}

class BlogGError extends UpdateBlogState {
  final String message;
  final String? details;
  BlogGError({
    required this.message,
    this.details,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlogGError &&
        other.message == message &&
        other.details == details;
  }

  @override
  int get hashCode => message.hashCode ^ details.hashCode;

  @override
  String toString() => 'BlogGError(message: $message, details: $details)';
}

extension UpdateBlogStateUnion on UpdateBlogState {
  T map<T>({
    required T Function(BlogUpdateInitial) blogUpdateInitial,
    required T Function(BlogUpdating) blogUpdating,
    required T Function(BlogUpdated) blogUpdated,
    required T Function(BlogUpdateError) blogUpdateError,
    required T Function(UnAuthorizedError) unAuthorizedError,
    required T Function(BlogGError) blogGError,
  }) {
    if (this is BlogUpdateInitial) {
      return blogUpdateInitial(this as BlogUpdateInitial);
    }
    if (this is BlogUpdating) {
      return blogUpdating(this as BlogUpdating);
    }
    if (this is BlogUpdated) {
      return blogUpdated(this as BlogUpdated);
    }
    if (this is BlogUpdateError) {
      return blogUpdateError(this as BlogUpdateError);
    }
    if (this is UnAuthorizedError) {
      return unAuthorizedError(this as UnAuthorizedError);
    }
    if (this is BlogGError) {
      return blogGError(this as BlogGError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}
