import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Center(
      child: Text(
        'In Progress...',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
      ),
    ));
  }
}
