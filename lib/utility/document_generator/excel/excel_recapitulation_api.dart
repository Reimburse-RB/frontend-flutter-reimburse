import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/utility/document_generator/excel/excel_api.dart';

class ExcelRecapitulationApi {
  ExcelRecapitulationApi({required this.context}) {}
  late BuildContext context;

  Future<File> generateExcelAllRecap({
    required List<ItemUserReimburseData> listRecapitulation,
    required bool isRangePicked,
  }) async {
    var excel = Excel.createExcel(); // Membuat dokumen Excel baru
    Sheet sheet = excel['Rekapitulasi']; // Membuat sheet baru dengan nama 'Rekapitulasi'

    buildTitle(sheet, "Rekapitulasi Reimbursement");
    buildHeader(sheet, isRangePicked);
    // Menambahkan header ke dalam sheet
    sheet.appendRow([
      TextCellValue('No'),
      TextCellValue('Tanggal Pengajuan'),
      TextCellValue('Nama Karyawan'),
      TextCellValue('Kategori'),
      TextCellValue('Status'),
      TextCellValue('Total Biaya'),
    ]);

    // Mengisi data ke dalam sheet
    for (int i = 0; i < listRecapitulation.length; i++) {
      final item = listRecapitulation[i];
      sheet.appendRow([
        TextCellValue('${i + 1}'),
        TextCellValue(item.createdDate ?? '-'),
        TextCellValue(item.name ?? ''),
        TextCellValue(item.typeReimburse ?? ''),
        TextCellValue(item.status ?? ''),
        TextCellValue(item.totalPrice.toString()),
      ]);
    }
    return ExcelApi.saveDocument(
      name: 'rekapitulasi.xlsx',
      excel: excel,
    );
  }

  Future<File> generateExcelDetail({
    required DetailReimburseData detailReimburseData,
  }) async {
    var excel = Excel.createExcel(); // Membuat dokumen Excel baru
    Sheet sheet = excel['Detail']; // Membuat sheet baru dengan nama 'Detail'

    // Menambahkan header ke dalam sheet
    sheet.appendRow([
      TextCellValue('No'),
      TextCellValue('Rincian'),
      TextCellValue('Peruntukkan'),
      TextCellValue('Tanggal Kuitansi'),
      TextCellValue('Keterangan'),
      TextCellValue('Biaya'),
    ]);

    // Mengisi data ke dalam sheet
    for (int i = 0; i < detailReimburseData.detailReimburse!.length; i++) {
      final item = detailReimburseData.detailReimburse![i];
      sheet.appendRow([
        TextCellValue('${i + 1}'),
        TextCellValue(item.detail_title_text ?? '-'),
        TextCellValue(item.detail_family_name ?? '-'),
        TextCellValue(item.detail_cost?.toString() ?? '-'),
        TextCellValue(item.detail_desc ?? '-'),
        TextCellValue(item.detail_cost.toString()),
      ]);
    }

    return ExcelApi.saveDocument(
      name: 'detail_reimburse.xlsx',
      excel: excel,
    );
  }

  // Fungsi untuk menambahkan judul utama
  void buildTitle(Sheet sheet, String title) {
    sheet.appendRow([TextCellValue(title)]);
    sheet.appendRow([]); // Tambahkan baris kosong untuk jarak
  }

  // Fungsi untuk menambahkan header/informasi tambahan
  void buildHeader(Sheet sheet, bool isRangePicked) {
    sheet.appendRow([
      TextCellValue('Periode Rekapitulasi:'),
      TextCellValue(isRangePicked ? 'Custom Range' : 'Semua Periode'),
    ]);
    sheet.appendRow([
      TextCellValue('Tanggal Pembuatan:'),
      TextCellValue(DateTime.now().toString()), // Tanggal saat ini
    ]);
    sheet.appendRow([]); // Tambahkan baris kosong untuk jarak
  }
}
