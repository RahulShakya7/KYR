import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/news_local_repo_impl.dart';
import '../../data/repository/news_remote_repo_impl.dart';
import '../entity/news_entity.dart';

final newsRepositoryProvider = Provider<INewsRepository>((ref) {
  // // Check for the internet
  final internetStatus = ref.watch(connectivityStatusProvider);

  if (ConnectivityStatus.isConnected == internetStatus) {
    // If internet is available then return remote repo
    return ref.watch(newsRemoteRepositoryProvider);
  } else {
    // If internet is not available then return local repo
    return ref.watch(newsLocalRepositoryProvider);
  }
});

abstract class INewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews();
  Future<Either<Failure, bool>> deleteNews(String newsid);
  Future<Either<Failure, NewsEntity>> singleNews(String newsId);
}
