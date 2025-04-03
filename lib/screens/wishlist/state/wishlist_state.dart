import 'package:dikla_spirit/custom/constants.dart';
import 'package:dikla_spirit/model/dashboard_model.dart';
import 'package:dikla_spirit/model/product_details_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WishlistState {
  final List<DashboardModelFastResult> quickSolutions;
  final List<DashboardModelFastResult> fastResults;
  final List<DashboardModelFastResult> favToExploreInWishList;
  final List<DashboardModelFastResult> youMayAlsoLikeThisInWishList;
  final List<DashboardModelFastResult> favToExploreInCart;
  final List<DashboardModelFastResult> productDetailFastResult;
  final List<DashboardModelFastResult> productDetailYouMayLikeThis;
  final List<DashboardModelFastResult> productCatList;
  final List<DashboardModelFastResult> wishlist;
  final List<DashboardModelFastResult> searchRecentPurchase;
  final List<DashboardModelFastResult> shopBestSellingWishlist;
  final ProductDetail productDetails;

  WishlistState(
      {required this.quickSolutions,
      required this.fastResults,
      required this.favToExploreInWishList,
      required this.youMayAlsoLikeThisInWishList,
      required this.favToExploreInCart,
      required this.productDetailFastResult,
      required this.productDetailYouMayLikeThis,
      required this.productCatList,
      required this.wishlist,
      required this.shopBestSellingWishlist,
      required this.productDetails,
      required this.searchRecentPurchase});

  WishlistState copyWith({
    List<DashboardModelFastResult>? quickSolutions,
    List<DashboardModelFastResult>? fastResults,
    List<DashboardModelFastResult>? favToExploreInWishList,
    List<DashboardModelFastResult>? youMayAlsoLikeThisInWishList,
    List<DashboardModelFastResult>? favToExploreInCart,
    List<DashboardModelFastResult>? productDetailFastResult,
    List<DashboardModelFastResult>? productDetailYouMayLikeThis,
    List<DashboardModelFastResult>? productCatList,
    List<DashboardModelFastResult>? wishlist,
    List<DashboardModelFastResult>? searchRecentPurchase,
    List<DashboardModelFastResult>? shopBestSellingWishlist,
    ProductDetail? productDetails,
  }) {
    return WishlistState(
        quickSolutions: quickSolutions ?? this.quickSolutions,
        fastResults: fastResults ?? this.fastResults,
        youMayAlsoLikeThisInWishList:
            youMayAlsoLikeThisInWishList ?? this.youMayAlsoLikeThisInWishList,
        favToExploreInWishList:
            favToExploreInWishList ?? this.favToExploreInWishList,
        favToExploreInCart: favToExploreInCart ?? this.favToExploreInCart,
        productDetailFastResult:
            productDetailFastResult ?? this.productDetailFastResult,
        productDetailYouMayLikeThis:
            productDetailYouMayLikeThis ?? this.productDetailYouMayLikeThis,
        wishlist: wishlist ?? this.wishlist,
        productCatList: productCatList ?? this.productCatList,
        shopBestSellingWishlist:
            shopBestSellingWishlist ?? this.shopBestSellingWishlist,
        productDetails: productDetails ?? this.productDetails,
        searchRecentPurchase:
            searchRecentPurchase ?? this.searchRecentPurchase);
  }
}

class WishlistNotifier extends StateNotifier<WishlistState> {
  WishlistNotifier()
      : super(WishlistState(
            quickSolutions: [],
            fastResults: [],
            favToExploreInWishList: [],
            favToExploreInCart: [],
            productDetailFastResult: [],
            productDetailYouMayLikeThis: [],
            youMayAlsoLikeThisInWishList: [],
            productCatList: [],
            wishlist: [],
            searchRecentPurchase: [],
            shopBestSellingWishlist: [],
            productDetails: ProductDetail()));

  void initializeFastResults(List<DashboardModelFastResult> fastResults) {
    state = state.copyWith(fastResults: fastResults);
  }

  void initializeQuickSolutions(List<DashboardModelFastResult> quickSolutions) {
    state = state.copyWith(quickSolutions: quickSolutions);
  }

  void initializeFavToExploreInWishList(
      List<DashboardModelFastResult> favToExplore) {
    state = state.copyWith(favToExploreInWishList: favToExplore);
  }

  void initializeYouMayAlsoLikeThisInWishList(
      List<DashboardModelFastResult> youMayAlsoLikeThis) {
    state = state.copyWith(youMayAlsoLikeThisInWishList: youMayAlsoLikeThis);
  }

  void initializeFavToExploreInCart(
      List<DashboardModelFastResult> favToExplore) {
    state = state.copyWith(favToExploreInCart: favToExplore);
  }

  void initializeProductDetailsFastResult(
      List<DashboardModelFastResult> productDetailsFastResult) {
    state = state.copyWith(productDetailFastResult: productDetailsFastResult);
  }

  void initializeProductDetailsYouMayLikeThis(
      List<DashboardModelFastResult> productDetailsYouMayLikeThis) {
    state = state.copyWith(
        productDetailYouMayLikeThis: productDetailsYouMayLikeThis);
  }

  void initializeProductCatList(List<DashboardModelFastResult> productCatList) {
    state = state.copyWith(productCatList: productCatList);
  }

  void initializeProductDetails(ProductDetail productDetails) {
    state = state.copyWith(productDetails: productDetails);
  }

  void initializeWishList(List<DashboardModelFastResult> wishList) {
    state = state.copyWith(wishlist: wishList);
  }

  void initializeWishListSearchRecentPurchase(
      List<DashboardModelFastResult> searchRecent) {
    state = state.copyWith(searchRecentPurchase: searchRecent);
  }

  void initializeShopBestSellingWishlist(
      List<DashboardModelFastResult> shopBestSellingWishlist) {
    state = state.copyWith(shopBestSellingWishlist: shopBestSellingWishlist);
  }

  void toggleWishlist(WishListType listType, {int? index}) {
    if (listType == WishListType.quick) {
      final updatedQuickSolutions =
          List<DashboardModelFastResult>.from(state.quickSolutions);
      updatedQuickSolutions[index!] = updatedQuickSolutions[index].copyWith(
        isWishlist: !updatedQuickSolutions[index].isWishlist!,
      );

      state = state.copyWith(quickSolutions: updatedQuickSolutions);
    } else if (listType == WishListType.fast) {
      final updatedFastResults =
          List<DashboardModelFastResult>.from(state.fastResults);
      updatedFastResults[index!] = updatedFastResults[index].copyWith(
        isWishlist: !updatedFastResults[index].isWishlist!,
      );

      state = state.copyWith(fastResults: updatedFastResults);
    } else if (listType == WishListType.favToExploreInWishList) {
      final updatedFavList =
          List<DashboardModelFastResult>.from(state.favToExploreInWishList);
      updatedFavList[index!] = updatedFavList[index]
          .copyWith(isWishlist: !updatedFavList[index].isWishlist!);
    } else if (listType == WishListType.youMayLikeThis) {
      final updatedYouMayLikeThisList = List<DashboardModelFastResult>.from(
          state.youMayAlsoLikeThisInWishList);
      updatedYouMayLikeThisList[index!] = updatedYouMayLikeThisList[index]
          .copyWith(isWishlist: !updatedYouMayLikeThisList[index].isWishlist!);
    } else if (listType == WishListType.favToExploreInCart) {
      final updatedFavList =
          List<DashboardModelFastResult>.from(state.favToExploreInCart);
      updatedFavList[index!] = updatedFavList[index]
          .copyWith(isWishlist: !updatedFavList[index].isWishlist!);
    } else if (listType == WishListType.productDetailFastResult) {
      final updatedProductDetailsFastResults =
          List<DashboardModelFastResult>.from(state.productDetailFastResult);
      updatedProductDetailsFastResults[index!] =
          updatedProductDetailsFastResults[index].copyWith(
              isWishlist: !updatedProductDetailsFastResults[index].isWishlist!);
    } else if (listType == WishListType.productDetailYouMayLikeThis) {
      final updatedproductDetailYouMayLikeThiss =
          List<DashboardModelFastResult>.from(state.productDetailFastResult);
      updatedproductDetailYouMayLikeThiss[index!] =
          updatedproductDetailYouMayLikeThiss[index].copyWith(
              isWishlist:
                  !updatedproductDetailYouMayLikeThiss[index].isWishlist!);
    } else if (listType == WishListType.productDetail) {
      var updatedProductDetails = state.productDetails.copyWith();

      updatedProductDetails = updatedProductDetails.copyWith(
          descriptionQa: updatedProductDetails.descriptionQa,
          price: updatedProductDetails.price,
          productImage: updatedProductDetails.productImage,
          rating: updatedProductDetails.rating,
          ratingCount: updatedProductDetails.ratingCount,
          shortDescription: updatedProductDetails.shortDescription,
          sizeToFit: updatedProductDetails.sizeToFit,
          stockQuantity: updatedProductDetails.stockQuantity,
          stockStatus: updatedProductDetails.stockStatus,
          template: updatedProductDetails.template,
          title: updatedProductDetails.title,
          type: updatedProductDetails.type,
          variations: updatedProductDetails.variations,
          isWishlist: !updatedProductDetails.isWishlist!);
    } else if (listType == WishListType.wishList) {
      final updatedWishlist =
          List<DashboardModelFastResult>.from(state.wishlist);
      updatedWishlist.removeAt(index!);
      state = state.copyWith(wishlist: updatedWishlist);
    } else if (listType == WishListType.productCatList) {
      final productCatList =
          List<DashboardModelFastResult>.from(state.productCatList);
      productCatList[index!] = productCatList[index]
          .copyWith(isWishlist: !productCatList[index].isWishlist!);
      state = state.copyWith(productCatList: productCatList);
    } else if (listType == WishListType.searchRecentPurchase) {
      final searchRecentPurchase =
          List<DashboardModelFastResult>.from(state.searchRecentPurchase);
      searchRecentPurchase[index!] = searchRecentPurchase[index]
          .copyWith(isWishlist: !searchRecentPurchase[index].isWishlist!);
      state = state.copyWith(searchRecentPurchase: searchRecentPurchase);
    } else if (listType == WishListType.shopBestSellingWishlist) {
      final shopBestSellingWishlist =
          List<DashboardModelFastResult>.from(state.shopBestSellingWishlist);
      shopBestSellingWishlist[index!] = shopBestSellingWishlist[index]
          .copyWith(isWishlist: !shopBestSellingWishlist[index].isWishlist!);
      state = state.copyWith(shopBestSellingWishlist: shopBestSellingWishlist);
    }
  }

  void removeFromWishlist(int index) {
    final updatedWishlist = List<DashboardModelFastResult>.from(state.wishlist);
    updatedWishlist.removeAt(index);
    state = state.copyWith(wishlist: updatedWishlist);
  }

  void updateItem(
    WishListType listType,
    DashboardModelFastResult updatedItem, {
    int? index,
  }) {
    if (listType == WishListType.quick) {
      final updatedQuickSolutions =
          List<DashboardModelFastResult>.from(state.quickSolutions);
      updatedQuickSolutions[index!] = updatedItem;

      state = state.copyWith(quickSolutions: updatedQuickSolutions);
    } else if (listType == WishListType.fast) {
      final updatedFastResults =
          List<DashboardModelFastResult>.from(state.fastResults);
      updatedFastResults[index!] = updatedItem;

      state = state.copyWith(fastResults: updatedFastResults);
    } else if (listType == WishListType.favToExploreInWishList) {
      final updatedFavResults =
          List<DashboardModelFastResult>.from(state.favToExploreInWishList);
      updatedFavResults[index!] = updatedItem;

      state = state.copyWith(favToExploreInWishList: updatedFavResults);
    } else if (listType == WishListType.youMayLikeThis) {
      final updatedYouMayLikeThisList = List<DashboardModelFastResult>.from(
          state.youMayAlsoLikeThisInWishList);
      updatedYouMayLikeThisList[index!] = updatedItem;

      state = state.copyWith(favToExploreInWishList: updatedYouMayLikeThisList);
    } else if (listType == WishListType.favToExploreInCart) {
      final updatedFavResults =
          List<DashboardModelFastResult>.from(state.favToExploreInCart);
      updatedFavResults[index!] = updatedItem;

      state = state.copyWith(favToExploreInCart: updatedFavResults);
    } else if (listType == WishListType.productDetailFastResult) {
      final updatedProductDetailsFastResult =
          List<DashboardModelFastResult>.from(state.productDetailFastResult);
      updatedProductDetailsFastResult[index!] = updatedItem;
      state = state.copyWith(
          productDetailFastResult: updatedProductDetailsFastResult);
    } else if (listType == WishListType.productDetailYouMayLikeThis) {
      final updatedProductDetailYouMayLikeThis =
          List<DashboardModelFastResult>.from(
              state.productDetailYouMayLikeThis);
      updatedProductDetailYouMayLikeThis[index!] = updatedItem;
      state = state.copyWith(
          productDetailYouMayLikeThis: updatedProductDetailYouMayLikeThis);
    } else if (listType == WishListType.productDetail) {
      // Ensure `state.productDetails` is not null before copying
      var updatedProductDetails =
          (state.productDetails ?? ProductDetail()).copyWith(
        isWishlist: !(state.productDetails.isWishlist ?? false),
      );

// Convert `updatedItem` (DashboardModelFastResult) into `ProductDetail`
      updatedProductDetails = updatedProductDetails.copyWith(
        title: updatedItem.title,
        price: updatedItem.price,
        rating: updatedItem.rating,
        ratingCount: updatedItem.ratingCount,
        isWishlist: updatedItem.isWishlist,
      );
      state = state.copyWith(productDetails: updatedProductDetails);
    } else if (listType == WishListType.productCatList) {
      final productCatList =
          List<DashboardModelFastResult>.from(state.productCatList);
      productCatList[index!] = updatedItem;
      state = state.copyWith(productCatList: productCatList);
    } else if (listType == WishListType.searchRecentPurchase) {
      final searchRecentPurchase =
          List<DashboardModelFastResult>.from(state.searchRecentPurchase);
      searchRecentPurchase[index!] = updatedItem;
      state = state.copyWith(searchRecentPurchase: searchRecentPurchase);
    } else if (listType == WishListType.shopBestSellingWishlist) {
      final shopBestSellingWishlist =
          List<DashboardModelFastResult>.from(state.shopBestSellingWishlist);
      shopBestSellingWishlist[index!] = updatedItem;
      state = state.copyWith(shopBestSellingWishlist: shopBestSellingWishlist);
    }
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, WishlistState>((ref) {
  return WishlistNotifier();
});
