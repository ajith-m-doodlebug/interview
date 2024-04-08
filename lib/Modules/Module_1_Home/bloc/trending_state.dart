part of 'trending_bloc.dart';

@immutable
sealed class TrendingState {}

final class TrendingInitial extends TrendingState {}

class FetchTrendingGifsLoadingState extends TrendingState {}

class FetchTrendingGifsFetchedState extends TrendingState {
  late final GifsResponseClass gifsResponseClass;
  FetchTrendingGifsFetchedState({required this.gifsResponseClass});
}

class FetchTrendingGifsErrorState extends TrendingState {}
