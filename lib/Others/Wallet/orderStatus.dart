import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import 'package:vroom_user/apis/checkOrderStatus.dart';

class OrderStatusPage extends StatefulWidget {
  final String orderValue;
  const OrderStatusPage({Key key, this.orderValue}) : super(key: key);

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  bool _isDelivered() => widget.orderValue == 'Goods Delivered';
  bool _isPurchased() => widget.orderValue == 'Goods have been Purchased';
  bool _isNull() => widget.orderValue == null;
  bool _isInNigeria() => widget.orderValue == 'Goods is in Nigeria';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: _isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Container(
                          height: Get.height * 0.60,
                          child: Timeline(
                            children: [
                              TimelineTile(
                                node: SizedBox(
                                  height: 50.0,
                                  child: _isNull()
                                      ? TimelineNode.simple()
                                      : TimelineNode(
                                          indicator: OutlinedDotIndicator(),
                                          startConnector: SolidLineConnector(),
                                          endConnector: SolidLineConnector(),
                                        ),
                                ),
                                contents: Card(
                                  elevation: 7,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction begins'),
                                  ),
                                ),
                              ),
                              TimelineTile(
                                node: SizedBox(
                                  child: _isPurchased()
                                      ? TimelineNode.simple()
                                      : TimelineNode(
                                          indicator: OutlinedDotIndicator(),
                                          startConnector: SolidLineConnector(),
                                          endConnector: SolidLineConnector(),
                                        ),
                                ),
                                oppositeContents: Card(
                                  elevation: 7,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Goods have been Purchased'),
                                  ),
                                ),
                              ),
                              TimelineTile(
                                node: SizedBox(
                                  child: _isInNigeria()
                                      ? TimelineNode.simple()
                                      : TimelineNode(
                                          indicator: OutlinedDotIndicator(),
                                          startConnector: SolidLineConnector(),
                                          endConnector: SolidLineConnector(),
                                        ),
                                ),
                                contents: Card(
                                  elevation: 7,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Goods is in Nigeria'),
                                  ),
                                ),
                              ),
                              TimelineTile(
                                node: SizedBox(
                                  child: _isDelivered()
                                      ? TimelineNode.simple()
                                      : TimelineNode(
                                          indicator: OutlinedDotIndicator(),
                                          startConnector: SolidLineConnector(),
                                          endConnector: SolidLineConnector(),
                                        ),
                                ),
                                oppositeContents: Card(
                                  elevation: 7,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Goods Delivered'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              if (_isDelivered())
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                          radius: 5,
                                          titleStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                          title: "Confirm delivery",
                                          middleText:
                                              'Once confirmed payment will be sent, please endure delivery occured',
                                          middleTextStyle:
                                              TextStyle(color: Colors.red),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                orderDeliverd().then((_) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                });
                                              },
                                              child: Text("Confirm"),
                                            ),
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ]);
                                    },
                                    child: Text(
                                      "Confirm Delivery",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )));
  }
}
