import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikla_spirit/custom/app_theme.dart';
import 'package:dikla_spirit/model/shop_list_model.dart';
import 'package:dikla_spirit/widgets/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShopPopupScreen extends ConsumerStatefulWidget {
  List<ShopListModelMenus> shopListModel;
  ShopPopupScreen(this.shopListModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ShopPopupScreen();
  }
}

class _ShopPopupScreen extends ConsumerState<ShopPopupScreen> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (context) {
        return Container(
            decoration: const BoxDecoration(
                color: AppTheme.appBarAndBottomBarColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close,
                          color: Colors.transparent,
                        )),
                    CustomText("Shop Categories",
                        ThemeData.light().textTheme.labelMedium!),
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppTheme.textColor,
                        ))
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: ScreenUtil().screenHeight / 2.15,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, top: 41.0, right: 18.0),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: ScreenUtil().setHeight(120)),
                        itemCount: widget.shopListModel.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // ref
                              //     .read(
                              //         subCategoryVisibilityProvider
                              //             .notifier)
                              //     .toggleBottomSheet();
                              if (widget
                                  .shopListModel[index].children!.isNotEmpty) {
                                Navigator.of(context).pop();
                                // showSubCategoryList();
                              }
                            },
                            child: Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: AppTheme.strokeColor
                                          .withOpacity(0.41)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().setWidth(70),
                                      child: CustomText(
                                          widget.shopListModel[index].title ??
                                              "",
                                          ThemeData.light()
                                              .textTheme
                                              .labelMedium!),
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(14)),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        imageUrl:
                                            widget.shopListModel[index].image ??
                                                "",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: SizedBox(
                                            height: ScreenUtil().setHeight(20),
                                            width: ScreenUtil().setWidth(20),
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ],
            ));
      },
      onClosing: () {},
    );
  }
}
