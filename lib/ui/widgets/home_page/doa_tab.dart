import 'package:alquran/providers/doa_provider.dart';
import 'package:alquran/ui/widgets/doa_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoaTab extends StatelessWidget {
  const DoaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DoaProvider>(
      builder: (_, value, __) {
        final doa = value.doa;
        if (value.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (value.errorMessage.isNotEmpty) {
          return Center(child: Text(value.errorMessage));
        }

        if (value.doa.isNotEmpty) {
          return ListView.builder(
            itemCount: value.doa.length,
            itemBuilder: (context, index) {
              return DoaItem(
                doa: doa[index],
                color: index % 2 == 0 ? Colors.grey.shade100 : Colors.white,
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
