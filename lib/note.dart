class Note {
  // NOTE: admin dan hrd menggunakan halaman yg sama, yg berbeda hanya data yang diterima/ akses
  List listRole = [
    {
      'role_id': 1,
      'role_text': 'Karyawan',
    },
    {
      'role_id': 2,
      'role_text': 'Administrator',
    },
    {
      'role_id': 3,
      'role_text': 'HRD',
    },
  ];

  List familyOption = [
    {
      'family_status_id': 1,
      'family_status_text': 'Diri sendiri',
    },
    {
      'family_status_id': 2,
      'family_status_text': 'Suami',
    },
    {
      'family_status_id': 3,
      'family_status_text': 'Istri',
    },
    {
      'family_status_id': 4,
      'family_status_text': 'Anak',
    },
  ];

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

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi
  Map detailReimbusrement = {
    'status_id': 1,
    'status_text': 'Menunggu Diproses',
    'name': 'Yudha Haryoputranto',
    'category_reimbursement_id': 1,
    'category_reimbursement_text': 'Reimbursement Kesehatan',
    'purpose_id': 20,
    'purpose_text': 'Flu Batuk',
    'total_cost': 400000,
    'list_attachment': [
      'https://picsum.photos/200/300',
      'https://picsum.photos/200/300',
      'https://picsum.photos/200/300',
      'https://picsum.photos/200/300',
    ],
    'list_detail': [
      {
        'detail_title_id': 1,
        'detail_title_text': 'Konsultasi Dokter',
        'detail_family_id': 3,
        'detail_family_name': 'Freya Jayawardana',
        'detail_date': '10/07/2024',
        'detail_cost': 200000,
        'detail_desc': 'lorem ipsum'
      },
      {
        'detail_title_id': 1,
        'detail_title_text': 'Konsultasi Dokter',
        'detail_family_id': 1,
        'detail_family_name': 'Yudha Haryoputranto',
        'detail_date': '10/07/2024',
        'detail_cost': 200000,
        'detail_desc': 'lorem ipsum'
      },
    ],
  };
}
