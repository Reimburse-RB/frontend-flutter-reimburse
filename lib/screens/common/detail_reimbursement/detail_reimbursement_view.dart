import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/detail_reimbursement/detail_reimbursement_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/card_detail_cost.dart';
import 'package:reimburse_rb/widgets/common/detail_text.dart';
import 'package:reimburse_rb/widgets/common/list_horizontal_detail_receipt_image.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

class DetailReimbursementScreen extends StatelessWidget {
  const DetailReimbursementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailReimbursementViewModel>(
      create: (_) => DetailReimbursementViewModel(context: context),
      child: const DetailReimbursementView(),
    );
  }
}

class DetailReimbursementView extends StatelessWidget {
  const DetailReimbursementView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailReimbursementViewModel>();
    final userProvider = context.read<UserProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Detail Reimbursement',
        actions: [
          if (viewModel.detailReimburseData != null)
            InkWell(
              onTap: () {
                Helper(context: context).generateAndOpenPdfFormatDetail(
                    detailReimburseData: viewModel.detailReimburseData!);
              },
              child: Icon(
                Icons.print_rounded,
                color: Colors.white,
              ),
            ),
        ],
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailText(
                  margin: EdgeInsets.only(top: 24),
                  title: 'Nama Karyawan',
                  textValue: viewModel.detailReimburseData?.name ?? '',
                  isHorizontal: true,
                ),
                DetailText(
                  title: 'Nomor Induk karyawan',
                  textValue: viewModel.detailReimburseData?.nik ?? '',
                  isHorizontal: true,
                ),
                DetailText(
                  title: 'Kategori',
                  textValue: viewModel.detailReimburseData?.category_reimbursement_text ?? '',
                  isHorizontal: true,
                ),
                DetailText(
                  title: (viewModel.detailReimburseData?.category_reimbursement_id ?? 1) ==
                          Constant.healthCategoryReimbursementId
                      ? 'Diagnosis'
                      : 'Tujuan',
                  textValue: viewModel.detailReimburseData?.purpose_text ?? '',
                  isHorizontal: true,
                ),
                DetailText(
                  title: 'Total Biaya',
                  costValue: viewModel.detailReimburseData?.totalPrice,
                  isHorizontal: true,
                ),
                DetailText(
                  margin: EdgeInsets.only(top: 24),
                  title: 'Status',
                  textValue: viewModel.detailReimburseData?.status_text ?? '',
                  valueBackgroundEnabled: true,
                  valueBackgroundColor: viewModel.statusColor ?? Colors.black,
                  valueColor: Colors.white,
                  isHorizontal: true,
                ),
                DetailText(
                  margin: EdgeInsets.only(top: 20),
                  title: 'Tanggal Pengajuan',
                  textValue: viewModel.detailReimburseData?.date ?? '',
                  valueColor: Colors.black,
                  isHorizontal: true,
                ),
                DetailText(
                  title: 'Tanggal Pembaruan Status',
                  textValue: viewModel.detailReimburseData?.approval_date ??
                      viewModel.detailReimburseData?.status_text ??
                      '',
                  valueColor: (viewModel.detailReimburseData?.approval_date == null)
                      ? viewModel.statusColor ?? Colors.black
                      : Colors.black,
                  isHorizontal: true,
                ),
                DetailText(
                  title: 'Penanggung Jawab',
                  textValue: (viewModel.detailReimburseData?.approval_by != null)
                      ? ((viewModel.detailReimburseData?.approval_by ?? '') +
                          ' (' +
                          (viewModel.detailReimburseData?.approval_by_role ?? '') +
                          ')')
                      : viewModel.detailReimburseData?.status_text ?? '',
                  valueColor: (viewModel.detailReimburseData?.approval_by == null)
                      ? viewModel.statusColor ?? Colors.black
                      : Colors.black,
                  isHorizontal: true,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Divider(
              height: 20,
              thickness: 20,
              color: Colors.grey.shade100,
            ),
            const SizedBox(height: 24),
            ListHorizontalDetailReceiptImage(
              title: 'Lampiran',
              listAttachment: viewModel.detailReimburseData?.list_attachment ?? [],
            ),
            const SizedBox(height: 24),
            Divider(
              height: 20,
              thickness: 20,
              color: Colors.grey.shade100,
            ),
            const SizedBox(height: 24),
            ListView.builder(
              itemCount: viewModel.detailReimburseData?.detailReimburse?.length ?? 0,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (viewModel.detailReimburseData!.detailReimburse != null) {
                  ItemDetailReimburseData item =
                      viewModel.detailReimburseData!.detailReimburse![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CardDetailCost(
                      itemDetailReimburseData: item,
                      categoryReimbursementId:
                          viewModel.detailReimburseData?.category_reimbursement_id,
                      index: index,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            if (userProvider.isAdmin) ...[
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    if (viewModel.detailReimburseData?.status_id == Constant.waitingStatusId) ...[
                      ButtonGeneral(
                        onTap: () {
                          viewModel.postChangeDetailReimbursement(
                            newStatusId: Constant.processStatusId,
                          );
                        },
                        text: 'Proses Pengajuan',
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (viewModel.detailReimburseData?.status_id == Constant.processStatusId) ...[
                      ButtonGeneral(
                        onTap: () {
                          viewModel.postChangeDetailReimbursement(
                            newStatusId: Constant.acceptedStatusId,
                          );
                        },
                        text: 'Setujui Pengajuan',
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (viewModel.detailReimburseData?.status_id == Constant.waitingStatusId ||
                        viewModel.detailReimburseData?.status_id == Constant.processStatusId)
                      ButtonGeneral(
                        onTap: () {
                          viewModel.postChangeDetailReimbursement(
                            newStatusId: Constant.rejectedStatusId,
                          );
                        },
                        text: 'Tolak Pengajuan',
                        isWhiteButton: true,
                      ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
