import 'package:dropper/main.export.dart';
import 'package:flutter/material.dart';

extension TestWiEx on Text {
  Widget markAsRequired([bool isRequired = true]) {
    return Builder(
      builder: (context) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: data,
                style: style,
              ),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: style?.copyWith(
                    color: context.colors.error,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
