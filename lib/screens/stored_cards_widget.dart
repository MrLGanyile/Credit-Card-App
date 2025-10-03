import 'package:credit_card_app/controller/credit_card_controller.dart';
import 'package:flutter/material.dart';

import '../model/card_info.dart';
import '../utilities.dart';

class StoredCardsWidget extends StatefulWidget {
  StoredCardsWidget();

  @override
  State<StatefulWidget> createState() => StoredCardsWidgetState();
}

class StoredCardsWidgetState extends State<StoredCardsWidget> {
  CreditCardController creditCardController = CreditCardController();
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: CreditCardController.storedCards.length,
        itemBuilder: (context, index) {
          CardInfo cardInfo = CreditCardController.storedCards[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Credit Card Number
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                    child: Text(
                      '${cardInfo.creditCardNumber} [${Utilities.convertCardTypeToString(cardInfo.cardType!)}] ${cardInfo.cvv}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Utilities.color3,
                      ),
                    ),
                  ),
                  // Issuing Country
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                    child: Text(
                      '${cardInfo.issuingCountry!.countryName} [${cardInfo.issuingCountry!.countryCode}]',
                      style: TextStyle(
                        fontSize: 16,
                        color: Utilities.color3,
                      ),
                    ),
                  ),
                ],
              ),
              // Remove Card
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Utilities.color1,
                ),
                onPressed: () => setState(() {
                  creditCardController.removeFromStoredCreditCards(cardInfo);
                }),
              )
            ],
          );
        },
      );
}
