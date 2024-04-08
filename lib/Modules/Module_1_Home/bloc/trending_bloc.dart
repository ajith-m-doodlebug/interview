import 'package:bloc/bloc.dart';
import 'package:interview_app/Api/search_api.dart';
import 'package:interview_app/Api/trending_api.dart';
import 'package:interview_app/Classes/gifs_response_class.dart';
import 'package:meta/meta.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc() : super(TrendingInitial()) {
    on<TrendingEvent>((event, emit) {});

    on<FetchTrendingGifs>((event, emit) async {
      emit.call(FetchTrendingGifsLoadingState());

      try {
        GifsResponseClass gifsResponseClass = await trendingAPI(offset: 1);
        if (gifsResponseClass.gifUrls.isNotEmpty) {
          emit.call(FetchTrendingGifsFetchedState(
              gifsResponseClass: gifsResponseClass));
        } else {
          emit.call(FetchTrendingGifsErrorState());
        }
      } catch (e) {
        emit.call(FetchTrendingGifsErrorState());
      }
    });

    on<FetchSearchGifs>((event, emit) async {
      emit.call(FetchTrendingGifsLoadingState());

      try {
        GifsResponseClass gifsResponseClass =
            await searchAPI(query: event.qruery);
        if (gifsResponseClass.gifUrls.isNotEmpty) {
          emit.call(FetchTrendingGifsFetchedState(
              gifsResponseClass: gifsResponseClass));
        } else {
          emit.call(FetchTrendingGifsErrorState());
        }
      } catch (e) {
        emit.call(FetchTrendingGifsErrorState());
      }
    });
  }
}
