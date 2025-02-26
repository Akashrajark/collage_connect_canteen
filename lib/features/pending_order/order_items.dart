import 'package:college_connect_canteen/common_widget/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class OrderedItems extends StatelessWidget {
  const OrderedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Items',
      content: Flexible(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemCount: 15,
          itemBuilder: (context, index) => Material(
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://images.pexels.com/photos/674574/pexels-photo-674574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'data',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('data')
                      ],
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('2x'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
