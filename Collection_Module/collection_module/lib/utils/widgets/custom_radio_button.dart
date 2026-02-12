import "package:flutter/material.dart";

import "../colors.dart";
import "../styles.dart";



//MULTIPLE RADIO BUTTON
Widget Ucoming_MultiRadioButton(
  context, {
  required int? groupValue1,
  required int? groupValue2,
  required int? groupValue3,
  required void Function(int?)? onChanged1,
  required void Function(int?)? onChanged2,
  required void Function(int?)? onChanged3,
  required String radioTxt1,
  required String radioTxt2,
  required String radioTxt3,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: 0,
              groupValue: groupValue1,
              activeColor:
                  buttonTextColor, // Active color for selected radio button
              onChanged: onChanged1, // Your onChanged logic
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(
              width: 5,
            ),
            RadioText(radioTxt1),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: groupValue2,
              activeColor:
                  buttonTextColor, // Active color for selected radio button
              onChanged: onChanged2, // Your onChanged logic
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(
              width: 5,
            ),
            RadioText(radioTxt2),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: groupValue3,
              activeColor:
                  buttonTextColor, // Active color for selected radio button
              onChanged: onChanged3, // Your onChanged logic
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(
              width: 5,
            ),
            RadioText(radioTxt3),
          ],
        ),
      ],
    ),
  );
}

//UPCOMMING MULTIRADIOBUTTON
Widget Upcoming_MultiRadioButton(
  context, {
  required int? groupValue1,
  required int? groupValue2,
  required int? groupValue3,
  required int? groupValue4,
  required void Function(int?)? onChanged1,
  required void Function(int?)? onChanged2,
  required void Function(int?)? onChanged3,
  required void Function(int?)? onChanged4,
  required String radioTxt1,
  required String radioTxt2,
  required String radioTxt3,
  required String radioTxt4,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: buttonTextColor),
    child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: groupValue1,
                activeColor:
                    buttonColor, // Active color for selected radio button
                onChanged: onChanged1, // Your onChanged logic
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              RadioText(radioTxt1),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: groupValue2,
                activeColor:
                    buttonColor, // Active color for selected radio button
                onChanged: onChanged2, // Your onChanged logic
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              RadioText(radioTxt2),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: groupValue3,
                activeColor:
                    buttonColor, // Active color for selected radio button
                onChanged: onChanged3, // Your onChanged logic
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              RadioText(radioTxt3),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 3,
                groupValue: groupValue4,
                activeColor:
                    buttonColor, // Active color for selected radio button
                onChanged: onChanged4, // Your onChanged logic
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              RadioText(radioTxt4),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget RadioText(String txt) {
  return Text(
    txt,
    style: radio_T_2,
    maxLines: 2,
  );
}
