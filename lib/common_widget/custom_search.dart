import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomSearch extends StatefulWidget {
  final Function(String?) onSearch;
  final Color fillColor;
  final TextStyle? textStyle;
  const CustomSearch({
    super.key,
    required this.onSearch,
    this.fillColor = Colors.transparent,
    this.textStyle,
  });

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController _searchController = TextEditingController();
  String _lastValue = '';

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {});
      // if (_searchController.text.trim().isEmpty && _lastValue.isNotEmpty) {
      //   widget.onSearch(null);
      //   _lastValue = '';
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _searchController,
                obscureText: false,
                style:
                    widget.textStyle ?? Theme.of(context).textTheme.titleSmall,
                onFieldSubmitted: (value) {
                  _lastValue = value.trim();
                  widget.onSearch(_lastValue);
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintStyle: widget.textStyle,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  filled: false,
                  isCollapsed: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
            SizedBox(
              width: _searchController.text.trim().isNotEmpty ? 15 : 0,
            ),
            InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                _lastValue = _searchController.text.trim();
                widget.onSearch(_lastValue);
                setState(() {});
              },
              child: const Icon(
                Icons.search,
                color: primaryColor,
              ),
            ),
            SizedBox(
              width: _lastValue.isNotEmpty ? 15 : 0,
            ),
            _lastValue.isNotEmpty
                ? InkWell(
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _lastValue = '';
                      _searchController.clear();
                      widget.onSearch(null);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
