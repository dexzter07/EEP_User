import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/features/resources/presentation/widgets/resource_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResourcesScreen extends ConsumerStatefulWidget {
  const ResourcesScreen({super.key});

  @override
  ConsumerState<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends ConsumerState<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideLeadingIcon: true,
      appBarTitle: 'Resource Access',
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      body: ListView(
        children: const [
          ResourceListWidget(
            iconData: Icons.save_outlined,
            title: 'Eco-Club Guidelines 2023',
            subtitle: 'Mon, May15, 2024',
          ),
          ResourceListWidget(
            iconData: Icons.event_available,
            title: 'World Environment Day Event',
            subtitle: 'Sun, June22, 2024',
          ),
          ResourceListWidget(
            iconData: Icons.save_outlined,
            title: 'Eco-Club Guidelines 2023',
            subtitle: 'Sun, June29, 2024',
          ),
          ResourceListWidget(
            iconData: Icons.event_available,
            title: 'Tree Planting Initiative',
            subtitle: 'Sat, July12, 2024',
          ),
          ResourceListWidget(
            iconData: Icons.save_outlined,
            title: 'Recycling Workshop Announcement',
            subtitle: 'Wed, July 19, 2024',
          ),
          ResourceListWidget(
            iconData: Icons.event_available,
            title: 'Summer Eco Challenge',
            subtitle: 'Tue, Aug03, 2024',
          ),
        ],
      ),
    );
  }
}
