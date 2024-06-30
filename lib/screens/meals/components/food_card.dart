import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/models/ingredients.dart';
import 'package:unlockway/screens/meals/components/food_info_popup.dart';

class IngredientCard extends StatefulWidget {
  const IngredientCard({
    super.key,
    required this.checked,
    required this.food,
    required this.onSelectIngredient,
    required this.initialValue,
    required this.onSumOrSubAmount,
  });

  final bool checked;
  final IngredientModel food;
  final Function(IngredientModel food, double amount) onSelectIngredient;
  final Function(double value, IngredientModel selectedFood) onSumOrSubAmount;
  final double initialValue;

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  TextEditingController amountController = TextEditingController(text: "0");
  String? measureText;
  double quantNumber = 0;

  bool selected = false;
  double add = 0;

  sumOrSub(String operation) {
    if (selected == true) {
      if (operation == "sum") {
        if (widget.food.measure == "AMOUNT") {
          add = 1;
          quantNumber = quantNumber + add;
          amountController.text = quantNumber.toString();
        } else if (widget.food.measure == "MILILITERS" ||
            widget.food.measure == "GRAMS") {
          add = 100;
          quantNumber = quantNumber + add;
          amountController.text = quantNumber.toString();
        }
      }
      if (operation == "sub" && quantNumber > 0) {
        if (widget.food.measure == "AMOUNT") {
          add = -1;
          quantNumber = quantNumber + add;
          amountController.text = quantNumber.toString();
        } else if (widget.food.measure == "MILILITERS" ||
            widget.food.measure == "GRAMS") {
          add = -100;
          quantNumber = quantNumber + add;
          amountController.text = quantNumber.toString();
        }
      }
      widget.onSumOrSubAmount(quantNumber, widget.food);
    }
  }

  @override
  void initState() {
    super.initState();
    selected = widget.checked;

    quantNumber = widget.initialValue;
    amountController.text = quantNumber.toString();

    if (widget.food.measure == "AMOUNT") {
      measureText = "Quant";
    } else if (widget.food.measure == "MILILITERS") {
      measureText = "MLs";
    } else if (widget.food.measure == "GRAMS") {
      measureText = "Gramas";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              modalBuilderBottomAnimation(
                context,
                FoodInfoPopup(
                  calories: widget.food.calories,
                  proteins: widget.food.proteins,
                  water: widget.food.water,
                  fats: widget.food.fats,
                  vitamins: widget.food.vitamins,
                  imgURL: widget.food.photo,
                  description: widget.food.description,
                  name: widget.food.name,
                ),
              );
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl: widget.food.photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.food.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 19,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onSelectIngredient(
                          widget.food,
                          quantNumber,
                        );
                        setState(
                          () {
                            if (selected == true) {
                              selected = !selected;
                              quantNumber = 0;
                              amountController.text = quantNumber.toString();
                            } else {
                              selected = !selected;
                            }
                          },
                        );
                      },
                      child: selected
                          ? Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Icon(
                                PhosphorIcons.check(PhosphorIconsStyle.regular),
                                size: 24.0,
                                color: Color(darkBg),
                              ),
                            )
                          : Container(
                              width: 30,
                              height: 30,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      child: Text(
                        measureText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 122,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                sumOrSub("sub");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              child: Icon(
                                PhosphorIcons.minus(PhosphorIconsStyle.regular),
                                size: 24.0,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: amountController,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                              ],
                              cursorColor:
                                  Theme.of(context).colorScheme.outline,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(12),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(darkBgdark)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(primarydark)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: "0",
                                hintStyle: const TextStyle(
                                  color: Color(0xFF616B7C),
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.onSurface,
                                focusColor:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                sumOrSub("sum");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              child: Icon(
                                PhosphorIcons.plus(PhosphorIconsStyle.regular),
                                size: 24.0,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
