import 'package:advisor/domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity {
  AdviceModel({required int id, required String advice})
      : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      id: json['id'],
      advice: json['advice'],
    );
  }
}
