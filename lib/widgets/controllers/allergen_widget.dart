import 'package:flutter/material.dart';
import 'package:fractoliotesting/dialogs/error_dialog.dart';
import 'package:fractoliotesting/widgets/addproduct.dart';

class AllergenListView extends StatefulWidget {
  final List<String> allergens;
  final Function(int) onRemoveAllergen;

  const AllergenListView(
      {super.key, required this.allergens, required this.onRemoveAllergen});

  @override
  AllergenListViewState createState() => AllergenListViewState();
}

class AllergenListViewState extends State<AllergenListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.allergens.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.allergens[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.onRemoveAllergen(index);
            },
          ),
        );
      },
    );
  }
}

class AllergenRow extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onAddAllergen;

  const AllergenRow(
      {super.key, required this.controller, required this.onAddAllergen});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BuildTextField(
            controller: controller,
            hintText: 'Enter allergen...',
            textAlign: TextAlign.center,
          ),
        ),
        FloatingActionButton.small(
          backgroundColor: Colors.orange,
          heroTag: "fab2",
          elevation: 3,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              onAddAllergen(controller.text);
            } else {
              showErrorDialog(context, "Add Allergens first");
            }
          },
        ),
      ],
    );
  }
}