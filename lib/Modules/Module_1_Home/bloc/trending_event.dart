part of 'trending_bloc.dart';

@immutable
sealed class TrendingEvent {}

class FetchTrendingGifs extends TrendingEvent {}

class FetchSearchGifs extends TrendingEvent {
  late final String qruery;
  FetchSearchGifs({required this.qruery});
}
