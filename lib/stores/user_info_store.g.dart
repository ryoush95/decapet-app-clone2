// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserInfoStore on _UserInfoStore, Store {
  final _$infoAtom = Atom(name: '_UserInfoStore.info');

  @override
  UserDto get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(UserDto value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  final _$_UserInfoStoreActionController =
      ActionController(name: '_UserInfoStore');

  @override
  void setInfo(UserDto? newValue) {
    final _$actionInfo = _$_UserInfoStoreActionController.startAction(
        name: '_UserInfoStore.setInfo');
    try {
      return super.setInfo(newValue);
    } finally {
      _$_UserInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
info: ${info}
    ''';
  }
}
