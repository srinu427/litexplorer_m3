import 'package:flutter/material.dart';

class LitShareDeviceDetails{
  final String name;
  final String ip;

  LitShareDeviceDetails(this.name, this.ip);
}

class LitShareElement extends StatelessWidget{
  final LitShareDeviceDetails deviceDetails;

  const LitShareElement({super.key, required this.deviceDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: (){},
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Icon(Icons.fireplace,size: 48,),
              const SizedBox(width: 8,),
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        deviceDetails.name,
                        style: const TextStyle(fontSize: 16,),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Text(
                      deviceDetails.ip,
                      style: const TextStyle(fontSize: 8,),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}