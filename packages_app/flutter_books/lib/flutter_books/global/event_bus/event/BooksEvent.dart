import 'package:ocean_common_module/ocean_common_module.dart';

/// 书籍刷新事件 EventBus
class BooksEvent extends AppEvent {
  BooksEvent(this.state, {String? id});

  final String state;

  @override
  List<Object?> get props => [state];
}
