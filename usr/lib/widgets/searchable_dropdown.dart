import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final String label;
  final String Function(T) itemToString;
  final ValueChanged<T?> onChanged;

  const SearchableDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    required this.label,
    required this.itemToString,
  }) : super(key: key);

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  late List<T> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _openDropdown() async {
    final result = await showDialog<T>(
      context: context,
      builder: (context) {
        String searchQuery = '';
        List<T> dialogFiltered = widget.items;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(widget.label),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                      dialogFiltered = widget.items
                          .where((item) => widget
                              .itemToString(item)
                              .toLowerCase()
                              .contains(searchQuery))
                          .toList();
                    });
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  height: 200,
                  child: dialogFiltered.isNotEmpty
                      ? ListView.builder(
                          itemCount: dialogFiltered.length,
                          itemBuilder: (context, index) {
                            final item = dialogFiltered[index];
                            return ListTile(
                              title: Text(widget.itemToString(item)),
                              onTap: () {
                                Navigator.of(context).pop(item);
                              },
                            );
                          },
                        )
                      : const Center(child: Text('No items found')),
                ),
              ],
            ),
          );
        });
      },
    );

    if (result != null) {
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openDropdown,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
        ),
        child: Text(
          widget.selectedValue != null
              ? widget.itemToString(widget.selectedValue as T)
              : '',
          style: TextStyle(color: widget.selectedValue != null ? Colors.black : Colors.grey[600]),
        ),
      ),
    );
  }
}