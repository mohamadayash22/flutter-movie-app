import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int number;
  final int season;
  final String name;
  final String runtime;
  final String stillPath;
  final String airDate;

  const Episode({
    required this.number,
    required this.season,
    required this.name,
    required this.runtime,
    required this.stillPath,
    required this.airDate,
  });

  @override
  List<Object?> get props => [
        number,
        season,
        name,
        runtime,
        stillPath,
        airDate,
      ];
}
