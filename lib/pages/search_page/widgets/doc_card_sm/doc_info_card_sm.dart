import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_patient/models/search_response_model/search_response_model.dart';
import 'package:proklinik_patient/pages/search_page/widgets/doc_card_sm/doc_data_sm_lower.dart';
import 'package:proklinik_patient/pages/search_page/widgets/doc_card_sm/doc_data_sm_upper.dart';
import 'package:proklinik_patient/pages/search_page/widgets/doc_card_sm/doc_image_sm.dart';
import 'package:proklinik_patient/pages/search_page/widgets/doc_card_sm/tags_row.dart';
import 'package:proklinik_patient/router/router.dart';

class DocInfoCardSm extends StatefulWidget {
  const DocInfoCardSm({
    super.key,
    required this.responseModel,
  });
  final SearchResponseModel responseModel;

  @override
  State<DocInfoCardSm> createState() => _DocInfoCardSmState();
}

class _DocInfoCardSmState extends State<DocInfoCardSm> {
  late final bool _toBuildTags;
  @override
  void initState() {
    super.initState();
    _toBuildTags = widget.responseModel.doctor_website_info.tags.isNotEmpty;
  }

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
              "docid": widget.responseModel.doctor.id.toString(),
            },
            extra: widget.responseModel,
          );
        },
        child: Container(
          height: _toBuildTags ? 450 : 370,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),

          ///main layout
          child: Column(
            children: [
              Expanded(
                flex: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),

                            ///image avatar
                            //todo: modify to recieve avatar link
                            DocImageSm(
                              doctor: widget.responseModel.doctor,
                            ),
                            const SizedBox(width: 10),

                            ///doctor data
                            DocDataSmUpper(
                              responseModel: widget.responseModel,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),

                      ///tag filer chips
                      if (_toBuildTags)
                        TagsRowXlSm(
                          tags: widget.responseModel.doctor_website_info.tags,
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 22,
                child: DocDataSmLower(
                  responseModel: widget.responseModel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
