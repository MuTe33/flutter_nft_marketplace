import 'package:flutter_marketplace/contracts/nftmarketplace.g.dart';
import 'package:flutter_marketplace/data/ipfs_repository.dart';
import 'package:web3dart/web3dart.dart';

class ContractRepository {
  ContractRepository(
    this._nftMarketplace,
    this._ipfsRepository,
  );

  final Nftmarketplace _nftMarketplace;
  final IpfsRepository _ipfsRepository;

  // fetch all NFTs for sale on the marketplace
  Future<void> getMarketNfts() async {
    final result = await _nftMarketplace.fetchMarketItems();
  }

  // fetch owned NFTs
  Future<void> getMyNfts() async {
    final result = await _nftMarketplace.fetchMyNFTs();
  }

  // fetch listed and owned NFTs on the marketplace
  Future<void> getListedNfts() async {
    final result = await _nftMarketplace.fetchItemsListed();
  }

  // resell an NFT you have purchased from someone else before
  Future<void> resellNft(BigInt tokenId, Credentials credentials) async {
    final listingPrice = await _nftMarketplace.getListingPrice();

    await _nftMarketplace.resellToken(
      tokenId,
      listingPrice,
      credentials: credentials,
    );
  }

  // fetch additional NFT meta data
  Future<void> getMetaDataOfNft(BigInt tokenId) async {
    final result = await _nftMarketplace.tokenURI(tokenId);
  }

  // buy NFT on marketplace
  Future<void> buyNft(BigInt tokenId, Credentials credentials) async {
    final result = await _nftMarketplace.createMarketSale(
      tokenId,
      credentials: credentials,
    );
  }

  // Mints a NFT and lists it in the marketplace
  Future<void> listNftForSale(
    Map<String, dynamic> data,
    Credentials credentials,
  ) async {
    // data is the meta data of the NFT.
    // It consists of name, description and image url
    final url = await _ipfsRepository.add(data);
    final listingPrice = await _nftMarketplace.getListingPrice();

    await _nftMarketplace.createToken(
      url,
      listingPrice,
      credentials: credentials,
    );
  }
}
