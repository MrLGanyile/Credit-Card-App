import 'package:credit_card_app/bloc/credit_card_repository_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/credit_card.dart';
import '../states/credit_card_repository.dart';
import '../utilities.dart';

class StoredCardsWidget extends StatelessWidget {
  StoredCardsWidget();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CreditCardRepositoryCubit, CreditCardRepository>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: Utilities.creditCardsRepository.storedCards.length,
            itemBuilder: (c, index) {
              CreditCard creditCard =
                  Utilities.creditCardsRepository.storedCards[index];
              return Column(
                children: [
                  // Issuing Country
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                    child: Text(
                      '${Utilities.convertCardTypeToString(creditCard.cardType!)}  ${creditCard.issuingCountry!.countryName} [${creditCard.issuingCountry!.countryCode}]',
                      style: TextStyle(
                        fontSize: 16,
                        color: Utilities.color3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Credit Card Number
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                    child: Text(
                      '${creditCard.creditCardNumber} ${creditCard.cvv}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Utilities.color3,
                      ),
                    ),
                  ),

                  // Remove Card
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Utilities.color1,
                    ),
                    onPressed: () {
                      c
                          .read<CreditCardRepositoryCubit>()
                          .removeFromStoredCreditCards(creditCard);
                    },
                  )
                ],
              );
            },
          );
        },
      );
}
