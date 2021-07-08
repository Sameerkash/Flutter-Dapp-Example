import 'package:chopper/chopper.dart';

import 'json_to_type_converter.dart';
import '../response/add.dart';
import '../response/cat.dart';

part 'ipfs_service.chopper.dart';

/// Provides access to API calls generated by chopper.
@ChopperApi(baseUrl: '/api/v0')
abstract class IpfsService extends ChopperService {
  @Post(path: '/add')
  @multipart
  Future<Response<Add>> add(@PartFile('path') List<int> file);

  @Post(path: '/cat', optionalBody: true)
  Future<Response<Cat>> cat(@Query('arg') String arg);

  static IpfsService create(String url) {
    final client = ChopperClient(
        baseUrl: url,
        services: [_$IpfsService()],
        converter: JsonToTypeConverter({
          Add: (jsonData) => Add.fromJson(jsonData),
          Cat: (jsonData) => Cat.fromJson(jsonData),
        }),
        interceptors: [HttpLoggingInterceptor()]);

    return _$IpfsService(client);
  }
}
