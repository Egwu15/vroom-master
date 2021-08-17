import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vroom_user/apis/quotation.dart';

showQuotationPopUp() {
  var theme = Theme.of(Get.context);
  bool _isLoading = false;

  Get.dialog(
    Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(clipBehavior: Clip.none, 
            children: [
              Image.asset(
                'assets/referNowBg.png',
                height: Get.height * 0.45,
                width: Get.width,
                fit: BoxFit.fill,
              ),
              PositionedDirectional(
                top: 40,
                start: 20,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: -50,
                start: 30,
                end: 30,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: theme.primaryColor,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'New quotation',
                          style: theme.textTheme.headline6.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 28),
              child: Text(
                "Check email",
                style: theme.textTheme.headline6.copyWith(
                    color: theme.primaryColor,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, right: 28, top: 16, bottom: 20),
              child: Text(
                "The details of the quotation is in your mail in a pdf file, please verify and agree or reject as soon as possible. Offer will automatically rejected in 48 hours.",
                style: theme.textTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: Get.width * 0.40,
                          child: OutlinedButton(
                            onPressed: () => acceptQuotaton(),
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 60,
                          width: Get.width * 0.40,
                          child: OutlinedButton(
                            onPressed: () => declineQuotaton(),
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    ),
  );
}
