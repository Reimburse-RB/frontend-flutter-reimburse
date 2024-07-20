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

  //=========================== API TNC ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // ENDPOINT : edit-tnc-reimbursement
  List<Map> bodyEditTncReimbursemnet = [
    {
      'category_reimbursement': 1,
      'list_tnc': [
        'Klaim harus mencakup biaya pengobatan yang sah dan terkait langsung dengan kesehatan pribadi karyawan.',
        'Dokumen asli seperti faktur rumah sakit, resep dokter, dan kwitansi pembayaran harus disertakan dengan klaim.',
        'Pengajuan klaim harus diajukan dalam waktu 30 hari setelah pembayaran dilakukan.',
      ]
    },
    {
      'category_reimbursement': 2,
      'list_tnc': [
        'Biaya transportasi yang dapat diklaim termasuk perjalanan dinas, tiket pesawat, transportasi darat, dan sewa kendaraan.',
        'Klaim harus mencakup rincian perjalanan seperti tujuan, tanggal perjalanan, dan jumlah biaya yang dikeluarkan.',
        'Dokumen pendukung seperti tiket, kwitansi, atau bukti pembayaran harus dilampirkan bersama dengan formulir klaim.',
      ]
    }
  ];

  // ENDPOINT : get-tnc-reimbursement
  List<Map> responseTncReimbursement = [
    {
      'category_reimbursement': 1,
      'title': 'Kategori Kesehatan',
      'list_tnc': [
        'Klaim harus mencakup biaya pengobatan yang sah dan terkait langsung dengan kesehatan pribadi karyawan.',
        'Dokumen asli seperti faktur rumah sakit, resep dokter, dan kwitansi pembayaran harus disertakan dengan klaim.',
        'Pengajuan klaim harus diajukan dalam waktu 30 hari setelah pembayaran dilakukan.',
      ]
    },
    {
      'category_reimbursement': 2,
      'title': 'Kategori Transportasi',
      'list_tnc': [
        'Biaya transportasi yang dapat diklaim termasuk perjalanan dinas, tiket pesawat, transportasi darat, dan sewa kendaraan.',
        'Klaim harus mencakup rincian perjalanan seperti tujuan, tanggal perjalanan, dan jumlah biaya yang dikeluarkan.',
        'Dokumen pendukung seperti tiket, kwitansi, atau bukti pembayaran harus dilampirkan bersama dengan formulir klaim.',
      ]
    }
  ];

  //=========================== API REIMBURSEMENT ================================

  // ENDPOINT : get-summary-home
  Map responseGetSummaryHome = {
    'onproceed': 1,
    'accepted': 6,
    'rejected': 2,
    'total_reimburse_this_year': 200000,
    'limit_reimburse': 5000000,
  };

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // family_status_id : 1 => Diri Sendiri
  // family_status_id : 2 => Suami
  // family_status_id : 3 => Istri
  // family_status_id : 4 => Anak

  // ENDPOINT : get-list-reimbursement
  Map bodyGetListReimbursementAll = {};
  Map bodyGetListReimbursementByStatus = {
    'status_id': 1,
  };
  List responseGetListReimbursement = [
    {
      'status_id': 1,
      'status_text': 'Menunggu Diproses',
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
    },
    {
      'status_id': 2,
      'status_text': 'Diproses',
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
    },
    {
      'status_id': 3,
      'status_text': 'Disetujui',
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
    },
    {
      'status_id': 3,
      'status_text': 'Ditolak',
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
    },
  ];

  // ENDPOINT : get-detail-reimbursement
  Map responseGetDetailReimbursement = {
    'status_id': 1,
    'status_text': 'Menunggu Diproses',
    'name': 'Yudha Haryoputranto',
    'category_reimbursement_id': 1,
    'category_reimbursement_text': 'Reimbursement Kesehatan',
    'date': '21/07/2024',
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

  //=========================== PROFILE ================================

  // role_id : 1 => Karyawan
  // role_id : 2 => Admin
  // role_id : 3 => HRD

  // family_status_id : 1 => Diri Sendiri
  // family_status_id : 2 => Suami
  // family_status_id : 3 => Istri
  // family_status_id : 4 => Anak

  // ENDPOINT : get-profile
  Map<String, dynamic> responseGetProfile = {
    'name': 'Yudha Haryoputranto',
    'email': 'yudhah52@gmail.com',
    'nik': '2010511068',
    'img_url':
        'https://media.licdn.com/dms/image/C5603AQFOfZiG507GCg/profile-displayphoto-shrink_800_800/0/1644315854486?e=1725494400&v=beta&t=AEKapy2te-iNY6J4Qz4NpHgllXpQdQVWV26YBBOAaWM',
    'role_id': 1,
    'role_text': 'Karyawan',
    'family_member_data': [
      {
        'family_status_id': 1,
        'family_status_text': 'Diri Sendiri',
        'name': 'Yudha Haryoputranto'
      },
      {
        'family_status_id': 3,
        'family_status_text': 'Istri',
        'name': 'Freya Jayawardana',
      },
      {
        'family_status_id': 4,
        'family_status_text': 'Anak',
        'name': 'Yhezra',
      },
    ]
  };

  // ENDPOINT : edit-profile
  Map<String, dynamic> bodyEditProfile = {
    'name': 'Yudha Haryoputranto',
    'email': 'yudhah52@gmail.com',
    'nik': '2010511068',
    'image_base64': '',
    'family_member_data': [
      {
        'family_status_id': 1,
        'family_status_text': 'Diri Sendiri',
        'name': 'Yudha Haryoputranto'
      },
      {
        'family_status_id': 3,
        'family_status_text': 'Istri',
        'name': 'Freya Jayawardana',
      },
      {
        'family_status_id': 4,
        'family_status_text': 'Anak',
        'name': 'Yhezra',
      },
    ],
  };

  //=========================== NOTIFICATION ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // ENDPOINT : get-employee-notification
  List responseGetEmployeeNotification = [
    {
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
      'status_id': 3,
      'status_text': 'Pengajuan Berhasil!',
      'status_desc':
          'Pengajuan reimburse Anda berhasil, silakan cek saldo rekening Anda',
    },
    {
      'category_reimbursement': 2,
      'category_reimbursement_text': 'Reimbursement Transportasi',
      'date': '21/07/2024',
      'status_id': 4,
      'status_text': 'Pengajuan Gagal!',
      'status_desc':
          'Pengajuan reimburse Anda gagal, silakan cek kembali dokumen terlampir yang tidak valid',
    },
    {
      'category_reimbursement': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
      'status_id': 3,
      'status_text': 'Pengajuan Berhasil!',
      'status_desc':
          'Pengajuan reimburse Anda berhasil, silakan cek saldo rekening Anda',
    },
  ];

  //=========================== RECAP ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // ENDPOINT : get-employee-year-recap
  List responseGetEmployeeYearRecap = [
    {'id': 24, 'year_text': '2023'},
    {'id': 23, 'year_text': '2024'},
  ];

  // ENDPOINT : get-employee-month-recap
  List responseGetEmployeeMonthRecap = [
    {'id': 523, 'month_text': 'Mei 2023'},
    {'id': 423, 'month_text': 'April 2023'},
    {'id': 323, 'month_text': 'Maret 2023'},
    {'id': 223, 'month_text': 'Februari 2023'},
    {'id': 123, 'month_text': 'Januari 2023'},
  ];

  // ENDPOINT : get-employee-month-recap
  List responseGetEmployeeListRecap = [
    {
      'status_id': 1,
      'status_text': 'Menunggu Diproses',
      'name': 'Yudha Haryoputranto',
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
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
    },
    {
      'status_id': 1,
      'status_text': 'Menunggu Diproses',
      'name': 'Yudha Haryoputranto',
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
      'date': '21/07/2024',
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
    },
  ];
}
