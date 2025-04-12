import 'package:flutter/material.dart';


class MyDropdown<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final Widget Function(T item) itemBuilder;
  final Widget? hint;

  const MyDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
    this.hint,
  });

  @override
  State<MyDropdown<T>> createState() => MyDropdownState<T>();
}

class MyDropdownState<T> extends State<MyDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  T? _selectedItem;

  // Call this method to open/close the dropdown programmatically
  void toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _isDropdownOpen = false);
    },);

  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.items.map((item) {
                return ListTile(
                  title: widget.itemBuilder(item),
                  onTap: () {
                    setState(() => _selectedItem = item);
                    widget.onChanged(item);
                    _closeDropdown();
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedItem != null
                  ? widget.itemBuilder(_selectedItem!)
                  : widget.hint ?? const Text('Select an item'),
              Icon(
                _isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }
}