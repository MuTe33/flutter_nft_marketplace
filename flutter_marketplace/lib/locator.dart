import 'package:dio/dio.dart' as dio;
import 'package:flutter_marketplace/contracts/nftmarketplace.g.dart';
import 'package:flutter_marketplace/data/contract_repository.dart';
import 'package:flutter_marketplace/data/ipfs_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

GetIt locator = GetIt.instance;
GetIt _l = locator;

Future<void> resetDependencies() async {
  await _l.reset();
}

void initSyncDependencies() {
  _initWeb3Client();
  _initDio();
  _initNftContract();
  _l.registerSingleton(ContractRepository(_l.get(), _l.get()));
  _l.registerSingleton(IpfsRepository(_l.get()));
}

void _initWeb3Client() {
  // TODO MATIC Urls from infura or alechmy
  const rinkebyAlchemyUrl =
      'https://eth-rinkeby.alchemyapi.io/v2/<YOUR_API_KEY>';
  const rinkebyAlchemyWss = 'wss://eth-rinkeby.alchemyapi.io/v2/<YOUR_API_KEY>';

  final client = Web3Client(
    rinkebyAlchemyUrl,
    Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(rinkebyAlchemyWss).cast<String>();
    },
  );

  _l.registerSingleton(client);
}

void _initDio() {
  final dioInstance = dio.Dio();

  _l.registerSingleton(dioInstance);
}

void _initNftContract() {
  final client = _l.get<Web3Client>();
  // TODO add contract address when contract is deployed
  final contractAddress = EthereumAddress.fromHex('TODO');

  final nftMarketplace = Nftmarketplace(
    address: contractAddress,
    client: client,
  );

  _l.registerSingleton(nftMarketplace);
}
