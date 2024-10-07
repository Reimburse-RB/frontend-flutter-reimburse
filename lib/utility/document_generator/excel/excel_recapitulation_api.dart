import 'dart:io';
import 'package:excel/excel.dart';
import 'package:excel/excel.dart' as excel;
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/document_generator/excel/excel_api.dart';
import 'package:reimburse_rb/utility/helper.dart';

class ExcelRecapitulationApi {
  ExcelRecapitulationApi({required this.context}) {}
  late BuildContext context;

  late int maxColumnIndex;
  late int initialRowIndexTable;

  excel.Border border = excel.Border(
    borderColorHex: "#FF000000".excelColor,
    borderStyle: excel.BorderStyle.Thin,
  );

  Future<File> generateExcelAllRecap({
    required List<ItemUserReimburseData> listRecapitulation,
    required bool isRangePicked,
  }) async {
    final userProvider = context.read<UserProvider>();
    maxColumnIndex = userProvider.isAdmin ? 7 : 6;
    initialRowIndexTable = userProvider.isAdmin ? 10 : 12;

    var excel = Excel.createExcel(); // Membuat dokumen Excel baru

    Sheet sheet = excel['Rekapitulasi']; // Membuat sheet baru dengan nama 'Rekapitulasi'
    excel.delete('Sheet1');

    buildTitle(sheet, "Rekapitulasi Reimbursement");
    buildDetailAllRecap(sheet, isRangePicked);
    buildTableAllRecap(sheet, listRecapitulation);
    return ExcelApi.saveDocument(
      name: 'rekapitulasi.xlsx',
      excel: excel,
    );
  }

  Future<File> generateExcelDetail({
    required DetailReimburseData detailReimburseData,
  }) async {
    maxColumnIndex = 5;
    initialRowIndexTable = 19;

    var excel = Excel.createExcel(); // Membuat dokumen Excel baru

    Sheet sheet = excel['Pengajuan Reimbursement']; // Membuat sheet baru dengan nama 'Detail'
    excel.delete('Sheet1');

    buildTitle(sheet, "Pengajuan Reimbursement");
    buildDetailOnly(sheet, detailReimburseData);
    buildTableDetailOnly(sheet, detailReimburseData);

    return ExcelApi.saveDocument(
      name: 'detail_reimburse.xlsx',
      excel: excel,
    );
  }

  // Fungsi untuk menambahkan judul utama
  void buildTitle(Sheet sheet, String title) {
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: 1),
    );

    sheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      TextCellValue(title),
      cellStyle: CellStyle(
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      ),
    );

    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 2),
      CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: 2),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 2),
      TextCellValue(Constant.companyName),
      cellStyle: CellStyle(
        fontSize: 10,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      ),
    );
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 3),
      CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: 4),
    );
    sheet.updateCell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 3),
      TextCellValue(Constant.addressRbCompany),
      cellStyle: CellStyle(
        fontSize: 8,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        textWrapping: TextWrapping.WrapText,
      ),
    );
  }

  void buildDetailAllRecap(Sheet sheet, bool isRangePicked) {
    final userProvider = context.read<UserProvider>();
    int currentRowIndex = 6; // Baris awal di mana pengisian dimulai

    List<String> mergeData = [
      'Periode Rekapitulasi \t: ${isRangePicked ? '${userProvider.selectedStartDateRangeRecap} - ${userProvider.selectedEndDateRangeRecap}' : '${userProvider.selectedRecapitulationMonth}'}',
      'Tanggal Pembuatan Dokumen \t: ${DateTime.now().toString()}',
    ];

    // Menambahkan data karyawan jika bukan admin
    if (!userProvider.isAdmin) {
      mergeData.addAll([
        'Nama Karyawan \t: ${userProvider.profileData?.name ?? ''}',
        'Nomor Induk Karyawan \t: ${userProvider.profileData?.nik ?? ''}',
      ]);
    }

    // Loop untuk melakukan merge dan menambahkan teks dengan row index yang fleksibel
    for (var text in mergeData) {
      sheet.merge(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRowIndex),
        CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: currentRowIndex),
        customValue: TextCellValue(text),
      );
      currentRowIndex++; // Increment row index setiap kali mengisi data
    }

    // Merge baris berikutnya (tanpa teks)
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRowIndex),
      CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: currentRowIndex),
    );
  }

  void buildTableAllRecap(
    Sheet sheet,
    List<ItemUserReimburseData> listRecapitulation,
  ) {
    final userProvider = context.read<UserProvider>();

    // Menambahkan header ke dalam sheet
    sheet.appendRow([
      TextCellValue('No'),
      TextCellValue('Tanggal Pengajuan'),
      if (userProvider.isAdmin) TextCellValue('Nama Karyawan'),
      TextCellValue('Kategori'),
      TextCellValue('Status'),
      TextCellValue('Tujuan/ Diagnosis'),
      TextCellValue('Penanggung Jawab'),
      TextCellValue('Total Biaya'),
    ]);
    addBorderToHeaderTable(sheet);

    // Mengisi data ke dalam sheet
    for (int i = 0; i < listRecapitulation.length; i++) {
      final item = listRecapitulation[i];
      sheet.appendRow([
        TextCellValue('${i + 1}'),
        TextCellValue(item.createdDate ?? '-'),
        if (userProvider.isAdmin) TextCellValue(item.name ?? '-'),
        TextCellValue(item.typeReimburse ?? '-'),
        TextCellValue(item.status ?? '-'),
        TextCellValue(item.purpose_text ?? '-'),
        TextCellValue(item.approval_by ?? item.status ?? '-'),
        TextCellValue(Helper(context: context).formatCurrency(amount: item.totalPrice ?? 0)),
      ]);
      addBorderToContentTable(sheet, i);
    }
  }

  void buildDetailOnly(Sheet sheet, DetailReimburseData detailReimburseData) {
    int currentRowIndex = 6; // Baris awal di mana pengisian dimulai

    List<String> mergeData = [
      'Nama Karyawan \t: ${detailReimburseData.name}',
      'Nomor Induk Karyawan \t: ${detailReimburseData.nik}',
      'Kategori Pengajuan \t: ${detailReimburseData.category_reimbursement_text}',
      'Tanggal Pengajuan \t: ${detailReimburseData.date}',
      'Tanggal Disetujui \t: ${detailReimburseData.approval_date ?? detailReimburseData.status_text}',
      'Tanggal Pembuatan Dokumen \t: ${DateTime.now().toString()}',
      'Tujuan/ Diagnosis \t: ${detailReimburseData.purpose_text}',
      'Total Biaya \t: ${Helper(context: context).formatCurrency(amount: detailReimburseData.totalPrice ?? 0)}',
      'Status Pengajuan \t: ${detailReimburseData.status_text}',
      'Penanggung Jawab \t: ${(detailReimburseData.approval_by != null) ? ': ${detailReimburseData.approval_by} (${detailReimburseData.approval_by_role})' : ': ${detailReimburseData.status_text}'}',
      'Rincian Biaya',
    ];

    // Loop untuk melakukan merge dan menambahkan teks dengan row index yang fleksibel
    for (var text in mergeData) {
      sheet.merge(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRowIndex),
        CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: currentRowIndex),
        customValue: TextCellValue(text),
      );
      currentRowIndex++; // Increment row index setiap kali mengisi data
    }

    // Merge baris berikutnya (tanpa teks)
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRowIndex),
      CellIndex.indexByColumnRow(columnIndex: maxColumnIndex, rowIndex: currentRowIndex),
    );
  }

  void buildTableDetailOnly(Sheet sheet, DetailReimburseData detailReimburseData) {
    // Menambahkan header ke dalam sheet
    sheet.appendRow([
      TextCellValue('No'),
      TextCellValue('Rincian'),
      TextCellValue('Peruntukkan'),
      TextCellValue('Tanggal Kuitansi'),
      TextCellValue('Keterangan'),
      TextCellValue('Biaya'),
    ]);

    addBorderToHeaderTable(sheet);

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
      addBorderToContentTable(sheet, i);
    }
  }

  void addBorderToHeaderTable(Sheet sheet) {
    for (int j = 0; j <= maxColumnIndex; j++) {
      var cell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: initialRowIndexTable - 1));
      cell.cellStyle = CellStyle(
        topBorder: border,
        bottomBorder: border,
        leftBorder: border,
        rightBorder: border,
        diagonalBorder: border,
      );
    }
  }

  void addBorderToContentTable(Sheet sheet, int indexContent) {
    for (int j = 0; j <= maxColumnIndex; j++) {
      final rowIndex = initialRowIndexTable + indexContent;
      var cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: rowIndex));
      cell.cellStyle = CellStyle(
        topBorder: border,
        bottomBorder: border,
        leftBorder: border,
        rightBorder: border,
        diagonalBorder: border,
      );
    }
  }
}
