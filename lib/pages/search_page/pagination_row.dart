import 'package:flutter/material.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class PaginationRow extends StatelessWidget {
  const PaginationRow({super.key});

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
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 40,
                    children: [
                      ...List.generate(20, (index) => (index + 1).toString())
                          .map((x) {
                        return ClickablePageNumber(
                          pageNumber: x,
                          isSelected: int.parse(x) == int.parse(sc.query.page),
                        );
                      })
                    ],
                  ),
                ),
                IconButton.outlined(
                  onPressed: () {},
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
      child: Card(
        elevation: (isHovering || widget.isSelected) ? 1 : 6,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              widget.pageNumber,
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
  }
}
