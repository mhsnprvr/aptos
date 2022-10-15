
import 'package:aptos/aptos_account.dart';
import 'package:aptos/aptos_client.dart';

class CoinClient {

  static const APTOS_COIN = "0x1::aptos_coin::AptosCoin";

  late AptosClient aptosClient;

  CoinClient(String endpoint) {
    aptosClient = AptosClient(endpoint);
  }

  Future<BigInt> checkBalance(String address, { String? coinType }) async {
    coinType ??= APTOS_COIN;
    String typeTag = "0x1::coin::CoinStore<$coinType>";
    final resources = await aptosClient.getAccountResources(address);
    final accountResource = resources.firstWhere((r) => r["type"] == typeTag);
    return BigInt.parse(accountResource["data"]["coin"]["value"]);
  }
}