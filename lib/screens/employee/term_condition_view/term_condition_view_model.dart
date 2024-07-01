import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/term_condition_data.dart';

class TermConditionViewModel extends ChangeNotifier {
  List<TermConditionData> termConditionList = [];

  List<Map> tempTermConditionList = [
    {
      'title': 'Kategori Kesehatan',
      'list_tnc': [
        'Klaim harus mencakup biaya pengobatan yang sah dan terkait langsung dengan kesehatan pribadi karyawan.',
        'Dokumen asli seperti faktur rumah sakit, resep dokter, dan kwitansi pembayaran harus disertakan dengan klaim.',
        'Pengajuan klaim harus diajukan dalam waktu 30 hari setelah pembayaran dilakukan.',
      ]
    },
    {
      'title': 'Kategori Transportasi',
      'list_tnc': [
        'Biaya transportasi yang dapat diklaim termasuk perjalanan dinas, tiket pesawat, transportasi darat, dan sewa kendaraan.',
        'Klaim harus mencakup rincian perjalanan seperti tujuan, tanggal perjalanan, dan jumlah biaya yang dikeluarkan.',
        'Dokumen pendukung seperti tiket, kwitansi, atau bukti pembayaran harus dilampirkan bersama dengan formulir klaim.',
      ]
    }
  ];

  TermConditionViewModel() {
    for (Map termCondition in tempTermConditionList) {
      termConditionList.add(TermConditionData.fromJson(termCondition));
    }
  }
}
