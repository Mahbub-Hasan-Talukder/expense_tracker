import 'package:equatable/equatable.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';

class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFetchEvent extends ItemEvent {}
