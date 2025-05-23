import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/functions/scroll_direction.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/providers/search_px.dart';
import 'package:proklinik_patient/router/router.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class PaginationRow extends StatefulWidget {
  const PaginationRow({super.key});

  @override
  State<PaginationRow> createState() => _PaginationRowState();
}

class _PaginationRowState extends State<PaginationRow> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void scrollNext() => scrollHorizontally(
        controller: _controller,
        direction: HorizontalScrollDirecion.next,
      );
  void scrollPrevious() => scrollHorizontally(
        controller: _controller,
        direction: HorizontalScrollDirecion.previous,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSearchController>(
      builder: (context, sc, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                const Spacer(),
                IconButton.outlined(
                  onPressed: scrollPrevious,
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  flex: context.isMobile ? 4 : 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // controller: _controller,
                      // scrollDirection: Axis.horizontal,
                      // itemExtent: 40,
                      children: [
                        //todo: generate from data
                        //TODO: Center page numbers in middle of list
                        ...List.generate(
                            (sc.responseModel == null ||
                                    sc.responseModel!.isEmpty ||
                                    sc.responseModel!.first.total_count / 10 <
                                        1)
                                ? 1
                                : (sc.responseModel!.first.total_count ~/ 10),
                            (index) => (index + 1).toString()).map((x) {
                          return SizedBox(
                            width: 40,
                            child: ClickablePageNumber(
                              pageNumber: x,
                              isSelected: int.parse(x) ==
                                  int.parse(sc.service.query.page),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                IconButton.outlined(
                  onPressed: scrollNext,
                  icon: const Icon(Icons.arrow_forward),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ClickablePageNumber extends StatefulWidget {
  const ClickablePageNumber({
    super.key,
    required this.pageNumber,
    required this.isSelected,
  });
  final String pageNumber;
  final bool isSelected;

  @override
  State<ClickablePageNumber> createState() => _ClickablePageNumberState();
}

class _ClickablePageNumberState extends State<ClickablePageNumber> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: Consumer2<PxSearchController, PxLocale>(
        builder: (context, sc, l, _) {
          return GestureDetector(
            onTap: () {
              /// navigation is linked to data brought by the api depending on
              /// the search paramenters(QueryObject)
              GoRouter.of(context).goNamed(
                AppRouter.src,
                pathParameters: {"lang": l.lang},
                queryParameters: sc.service.query
                    .copyWith(
                      page: widget.pageNumber,
                    )
                    .toJson(),
              );
            },
            child: Card(
              elevation: (isHovering || widget.isSelected) ? 1 : 6,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.pageNumber.toArabicNumber(context),
                    style: TextStyle(
                      color: (isHovering || widget.isSelected)
                          ? AppTheme.secondaryOrangeColor
                          : AppTheme.mainFontColor,
                      fontWeight: (isHovering || widget.isSelected)
                          ? FontWeight.bold
                          : FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
