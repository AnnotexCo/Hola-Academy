import 'package:equatable/equatable.dart';
import '../Data/Model/requests_model.dart';

abstract class RequestsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class RequestsInitial extends RequestsState{}

class RequestsLoading extends RequestsState{}

class AllRequestsSuccess extends RequestsState{
  final List<RequestsModel> requestsList;
  AllRequestsSuccess( this.requestsList);

  @override
  List<Object?> get props => [requestsList];
}

class SingleRequestSuccess extends RequestsState{
  final RequestsModel request;
  SingleRequestSuccess( this.request);

  @override
  List<Object?> get props => [request];
}

class RequestsError extends RequestsState{
  final String message;
  RequestsError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookRequestSuccess extends RequestsState{

}