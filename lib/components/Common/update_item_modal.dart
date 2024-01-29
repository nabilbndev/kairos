import 'package:flutter/material.dart';
import 'package:kairos/components/Common/kairos_text_button.dart';

class UpdateItemModal extends StatefulWidget {
  const UpdateItemModal(
      {super.key,
      required this.title,
      required this.textController,
      required this.onTap});
  final String title;
  final TextEditingController textController;
  final VoidCallback onTap;

  @override
  State<UpdateItemModal> createState() => _AddItemModalState();
}

class _AddItemModalState extends State<UpdateItemModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Container(
                  height: 8,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5),
                          width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder()),
                controller: widget.textController,
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  KairosTextButton(
                      buttonColor: Colors.white,
                      buttonBorderColor: Colors.grey.withOpacity(0.5),
                      textColor: Colors.red,
                      onTap: () {
                        widget.textController.clear();
                        Navigator.pop(context);
                      },
                      text: "Cancel"),
                  const SizedBox(
                    width: 10,
                  ),
                  KairosTextButton(
                      buttonColor: Colors.black,
                      buttonBorderColor: Colors.black,
                      textColor: Colors.white,
                      onTap: widget.onTap,
                      text: "Update")
                ],
              ),
            )
          ],
        ));
  }
}
