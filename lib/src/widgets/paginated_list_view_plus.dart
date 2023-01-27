import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_plus/skadi_plus.dart';

class SkadiPaginatedListViewPlus extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool hasRefreshButtonWhenEmpty;
  final FutureFunction onGetMoreData;
  final EdgeInsets? padding;
  final Axis? scrollDirection;
  final IndexedWidgetBuilder? separatorBuilder;
  final bool shrinkWrap;
  final Widget? onEmpty;
  final ScrollController? controller;
  final Widget Function(FutureFunction, FutureManagerError)? errorWidget;
  final PaginationHandler paginationHandler;
  //
  const SkadiPaginatedListViewPlus({
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    required this.paginationHandler,
    required this.onGetMoreData,
    Key? key,
    this.padding,
    this.scrollDirection,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.onEmpty,
    this.controller,
    this.hasRefreshButtonWhenEmpty = true,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = SkadiProvider.of(context);
    if (itemCount == 0) {
      return onEmpty ??
          provider?.noDataWidget
              ?.call(hasRefreshButtonWhenEmpty ? onRefresh : null) ??
          emptySizedBox;
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SkadiPaginatedListView(
        padding: padding ?? EdgeInsets.zero,
        scrollController: controller,
        hasMoreData: paginationHandler.hasMoreData,
        itemBuilder: itemBuilder,
        dataLoader: onGetMoreData,
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection ?? Axis.vertical,
        itemCount: itemCount,
        separatorBuilder: separatorBuilder,
        hasError: paginationHandler.manager.hasError,
        loadingWidget: provider?.loadingWidget,
        errorWidget: errorWidget != null
            ? () {
                return errorWidget!.call(
                  () async {
                    paginationHandler.manager.clearError();
                    await onGetMoreData();
                  },
                  paginationHandler.manager.error!,
                );
              }
            : null,
      ),
    );
  }
}
