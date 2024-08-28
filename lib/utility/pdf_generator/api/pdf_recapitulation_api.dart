import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/pdf_generator/api/pdf_api.dart';

class PdfRecapitulationApi {
  PdfRecapitulationApi({required this.context}) {}
  late BuildContext context;

  Future<File> generatePdfAllRecap(
      {required List<ItemUserReimburseData> listRecapitulation}) async {
    final pdf = Document();

    final imageCompany = (await rootBundle.load(Constant.imageRbCompany)).buffer.asUint8List();
    final userProvider = context.read<UserProvider>();

    pdf.addPage(MultiPage(
      build: (context) => [
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildHeader(imageCompany),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitle('Rekapitulasi Reimbursement'),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildDetailAllRecap(),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildTableAllRecap(listRecapitulation),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            buildSignature(
              role: userProvider.profileData?.role_text ?? '-',
              name: userProvider.profileData?.name ?? '-',
              nik: userProvider.profileData?.nik ?? '-',
            ),
          ],
        ),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: 'recapitulation.pdf', pdf: pdf);
  }

  Future<File> generatePdfDetail({required DetailReimburseData detailReimburseData}) async {
    final pdf = Document();

    final imageCompany = (await rootBundle.load(Constant.imageRbCompany)).buffer.asUint8List();
    final userProvider = context.read<UserProvider>();

    pdf.addPage(MultiPage(
      build: (context) => [
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildHeader(imageCompany),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitle('Pengajuan Reimbursement'),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildDetailOnly(detailReimburseData),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildTableOnly(detailReimburseData),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Container(
          margin: pw.EdgeInsets.symmetric(horizontal: 48),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              buildSignature(
                role: 'Karyawan',
                name: detailReimburseData.name ?? '-',
                nik: detailReimburseData.nik ?? '-',
              ),
              buildSignature(
                role: userProvider.profileData?.role_text ?? '-',
                name: userProvider.profileData?.name ?? '-',
                nik: userProvider.profileData?.nik ?? '-',
              ),
            ],
          ),
        ),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(name: 'recapitulation-detail.pdf', pdf: pdf);
  }

  static pw.Widget buildHeader(imageCompany) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        buildCompanyAddress(),
        pw.Container(
          height: 50,
          width: 50,
          child: pw.Image(
            pw.MemoryImage(imageCompany),
          ),
        ),
      ],
    );
  }

  static pw.Widget buildCompanyAddress() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            Constant.addressRbCompany,
            style: pw.TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          ),
        ],
      );

  static pw.Widget buildTitle(String title) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.Text(
            title,
            textAlign: TextAlign.center,
            style: pw.TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          pw.Divider(),
        ],
      );

  static pw.Widget buildFooter() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Text(
            'Dokumen ini dibuat secara otomatis menggunakan Aplikasi Reimburse RB pada ${DateFormat('dd/MM/yyyy').format(
              DateTime.now(),
            )}',
            style: const pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
        ],
      );

  pw.Widget buildDetailAllRecap() {
    final userProvider = context.read<UserProvider>();

    return pw.TableHelper.fromTextArray(
      tableWidth: TableWidth.min,
      border: pw.TableBorder.all(style: pw.BorderStyle.none),
      data: [
        ['Periode Reimburse', ': ${userProvider.selectedRecapitulationMonth}'],
      ],
      cellStyle: const pw.TextStyle(fontSize: 12),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
      },
    );
  }

  pw.Widget buildTableAllRecap(List<ItemUserReimburseData> data) {
    return pw.TableHelper.fromTextArray(
      headers: [
        'No',
        'Tanggal Pengajuan',
        'Nama Karyawan',
        'Kategori',
        'Status',
        'Tujuan/ Diagnosis',
        'Penanggung Jawab',
        'Biaya'
      ],
      data: data.asMap().entries.map((entry) {
        int index = entry.key + 1;
        ItemUserReimburseData item = entry.value;
        return [
          '$index',
          item.createdDate ?? '-',
          item.name ?? '-',
          item.typeReimburse ?? '-',
          item.status ?? '-',
          '-', // As Tujuan/Diagnosis is not present in the data, it’s set to '-'
          'Yhezra (Admin)', // Assuming the admin is static in this context
          'Rp ${Helper(context: context).formatCurrency(amount: item.totalPrice ?? 0)}',
        ];
      }).toList(),
      cellStyle: const pw.TextStyle(fontSize: 10),
      headerStyle: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerLeft,
        5: pw.Alignment.centerLeft,
        6: pw.Alignment.centerLeft,
        7: pw.Alignment.centerLeft,
      },
      headerAlignment: pw.Alignment.center,
    );
  }

  pw.Widget buildDetailOnly(DetailReimburseData detailReimburseData) {
    return pw.TableHelper.fromTextArray(
      tableWidth: TableWidth.min,
      border: pw.TableBorder.all(style: pw.BorderStyle.none),
      data: [
        ['Nama Karyawan', ': ${detailReimburseData.name}'],
        ['Nomor Induk Karyawan', ': ${detailReimburseData.nik}'],
        ['Kategori Pengajuan', ': ${detailReimburseData.category_reimbursement_text}'],
        ['Tanggal Pengajuan', ': ${detailReimburseData.date}'],
        ['Tanggal Disetujui', ': TANGGAL DISETUJUI \\ BELUM ADA DATA DARI API'],
        ['Tujuan/ Diagnosis', ': TUJUANNYA APA \\ BELUM ADA DATA DARI API'],
        ['Total Biaya', ': ${detailReimburseData.totalPrice}'],
        ['Status Pengajuan', ': ${detailReimburseData.status_text}'],
        ['Penanggung Jawab', ':  SIAPA (Admin/HRD) \\ BELUM ADA DATA DARI API'],
        ['Rincian Biaya', ': '],
      ],
      cellStyle: const pw.TextStyle(fontSize: 12),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
      },
    );
  }

  pw.Widget buildTableOnly(DetailReimburseData detailReimburseData) {
    return pw.TableHelper.fromTextArray(
      headers: [
        'No',
        'Rincian',
        'Peruntukkan',
        'Tanggal Kuitansi',
        'Keterangan',
        'Biaya',
      ],
      data: detailReimburseData.detailReimburse!.asMap().entries.map((entry) {
        int index = entry.key + 1;
        ItemDetailReimburseData item = entry.value;
        return [
          '$index',
          item.detail_title_text ?? '-',
          item.detail_family_name ?? '-',
          item.detail_cost ?? '-',
          item.detail_desc ?? '-',
          'Rp ${Helper(context: context).formatCurrency(amount: item.detail_cost ?? 0)}',
        ];
      }).toList(),
      cellStyle: const pw.TextStyle(fontSize: 10),
      headerStyle: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerLeft,
        5: pw.Alignment.centerLeft,
        6: pw.Alignment.centerLeft,
      },
      headerAlignment: pw.Alignment.center,
    );
  }

  pw.Widget buildSignature({required String role, required String name, required String nik}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          'TTD $role',
          style: const pw.TextStyle(fontSize: 12),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          name,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          nik,
          style: const pw.TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
