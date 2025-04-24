import 'package:flutter_advance_course/data/network/error_handler.dart';

import '../responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 MINUTE IN MILLIS

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<StoreDetailsResponse> getStoreDetails1();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<void> saveStoreDetailsToCache(
      StoreDetailsResponse storeDetailsResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CacheItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHome() async {
    CacheItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails1() {
    CacheItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CacheItem(homeResponse);
  }

  @override
  Future<void> saveStoreDetailsToCache(
      StoreDetailsResponse storeDetailsResponse) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CacheItem(storeDetailsResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CacheItem {
  dynamic data;

  int cacheItem = DateTime.now().millisecondsSinceEpoch;

  CacheItem(this.data);
}

extension CacheItemExtension on CacheItem {
  bool isValid(int expirationTime) {
    // expirationTime is 60 secs
    // time now is 1:00:00 pm
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    // cache time was 12:59:30
    bool isCacheValid = currentTimeInMillis - expirationTime < cacheItem;
    // false if current time > 1:00:30
    // true if current time < 1:00:30
    return isCacheValid;
  }
}
