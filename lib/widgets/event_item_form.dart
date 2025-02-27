import 'package:flutter/material.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/widgets/customTextFromField.dart';

class EventItemForm extends StatefulWidget {
  final RequiredItem? item;
  final Function(RequiredItem) onSave;

  const EventItemForm({
    Key? key,
    this.item,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EventItemForm> createState() => _EventItemFormState();
}

class _EventItemFormState extends State<EventItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  bool _isRequired = true;

  @override
  void initState() {
    super.initState();
    
    _nameController = TextEditingController(text: widget.item?.itemName ?? '');
    _descriptionController = TextEditingController(text: widget.item?.description ?? '');
    _isRequired = widget.item?.isRequired ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 16.0 + bottomInset,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item == null
                  ? 'Add Required Item'
                  : 'Edit Required Item',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _nameController,
              labelText: 'Item Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an item name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _descriptionController,
              labelText: 'Description (Optional)',
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Required'),
              subtitle: const Text('Is this item mandatory for participants?'),
              value: _isRequired,
              onChanged: (value) {
                setState(() {
                  _isRequired = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(
                      RequiredItem(
                        id: widget.item?.id,
                        itemName: _nameController.text,
                        description: _descriptionController.text.isNotEmpty
                            ? _descriptionController.text
                            : null,
                        isRequired: _isRequired,
                      ),
                    );
                  }
                },
                child: Text(widget.item == null ? 'Add Item' : 'Update Item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}