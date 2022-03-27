import 'package:dio/dio.dart';
import 'package:path/path.dart';

const baseUrl = 'https://ipfs.infura.io:5001/api/v0/';

class IpfsRepository {
  IpfsRepository(this._dio);

  final Dio _dio;

  // uploads file to IPFS and returns file url
  Future<String> add(Map<String, dynamic> data) async {
    // upload file to IPFS
    final filePath = await _dio.post(
      join(baseUrl, 'add'),
      data: FormData.fromMap(data),
    );

    // after metadata is uploaded to IPFS, return the URL to use it
    return 'https://ipfs.infura.io/ipfs/${filePath.data}';
  }
}
