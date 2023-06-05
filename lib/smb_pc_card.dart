import 'package:flutter/material.dart';

class SMBElement extends StatelessWidget{
  final String ip;

  const SMBElement({super.key, required this.ip});

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
              const Icon(Icons.desktop_windows_outlined,size: 48,),
              const SizedBox(width: 8,),
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        ip,
                        style: const TextStyle(fontSize: 16,),
                        overflow: TextOverflow.fade,
                      ),
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