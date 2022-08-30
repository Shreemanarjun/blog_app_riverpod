abstract class AddBlogState {
  const AddBlogState();
}

class BlogInitial extends AddBlogState {
  const BlogInitial();
}

class BlogAdding extends AddBlogState {
  const BlogAdding();
}

class BlogAdded extends AddBlogState {
  const BlogAdded();
}

class BlogAddError extends AddBlogState {
  const BlogAddError();
}

class BlogError extends AddBlogState {
  final String message;
  final String? details;
  const BlogError({required this.message, this.details});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BlogError &&
      other.message == message &&
      other.details == details;
  }

  @override
  int get hashCode => message.hashCode ^ details.hashCode;

  @override
  String toString() => 'BlogError(message: $message, details: $details)';
}

class BlogUnauthorizedError extends AddBlogState {
  const BlogUnauthorizedError();
}

extension AddBlogStateUnion on AddBlogState {
  T map<T>({
    required T Function(BlogInitial) blogInitial,
    required T Function(BlogAdding) blogAdding,
    required T Function(BlogAdded) blogAdded,
    required T Function(BlogAddError) blogAddError,
    required T Function(BlogError) blogError,
    required T Function(BlogUnauthorizedError) blogUnauthorizedError,
  }) {
    if (this is BlogInitial) {
      return blogInitial(this as BlogInitial);
    }
    if (this is BlogAdding) {
      return blogAdding(this as BlogAdding);
    }
    if (this is BlogAdded) {
      return blogAdded(this as BlogAdded);
    }
    if (this is BlogAddError) {
      return blogAddError(this as BlogAddError);
    }
    if (this is BlogError) {
      return blogError(this as BlogError);
    }
    if (this is BlogUnauthorizedError) {
      return blogUnauthorizedError(this as BlogUnauthorizedError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}