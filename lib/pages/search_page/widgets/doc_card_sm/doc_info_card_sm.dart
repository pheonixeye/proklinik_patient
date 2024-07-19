import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/doc_data_sm_lower.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/doc_data_sm_upper.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/doc_image_sm.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/tags_row.dart';
import 'package:patient/router/router.dart';
import 'package:proklinik_models/models/server_response_model.dart';

class DocInfoCardSm extends StatelessWidget {
  const DocInfoCardSm({
    super.key,
    required this.responseModel,
  });
  final ServerResponseModel responseModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          //todo: navigate to doctor profile page by id
          GoRouter.of(context).goNamed(
            AppRouter.docquery,
            pathParameters: {
              ...defaultPathParameters(context),
              "docid": responseModel.doctor.id.toString(),
            },
          );
        },
        child: Container(
          height: 450,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),

          ///main layout
          child: Column(
            children: [
              Expanded(
                flex: 160,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),

                            ///image avatar
                            //todo: modify to recieve avatar link
                            DocImageSm(
                              doctor: responseModel.doctor,
                            ),
                            const SizedBox(width: 10),

                            ///doctor data
                            DocDataSmUpper(
                              responseModel: responseModel,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),

                      ///tag filer chips
                      TagsRowXlSm(
                        doctor: responseModel.doctor,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 220,
                child: DocDataSmLower(
                  responseModel: responseModel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
