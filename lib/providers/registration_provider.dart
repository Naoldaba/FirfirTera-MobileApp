import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'registration_provider.g.dart';


// first page provider saves it to first page map, and so and so forth

Map <String ,dynamic>  firstPageMap = {};

@Riverpod()
class RegisterOne extends _$RegisterOne{

  @override
  Map<String, dynamic> build(){
    return firstPageMap;
  }

  void addValue(Map<String, dynamic> page){
    firstPageMap = page;
  }

}
// provider for first page

@riverpod
Map<String, dynamic> MyfirstPageMap(ref){
  return firstPageMap;
}


// provider for second page

Map <String ,dynamic>  secondPageMap = {};

@Riverpod()
class RegisterTwo extends _$RegisterTwo{

  @override
  Map<String, dynamic> build(){
    return secondPageMap;
  }

  void addValue(Map<String, dynamic> page){
    secondPageMap = page;
  }

}

// provide 
 
@riverpod
Map<String, dynamic> MysecondPageMap(ref){
  return secondPageMap;
}
