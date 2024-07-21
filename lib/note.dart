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

  List listCategoryReimbursement = [
    {
      'category_reimbursement_id': 1,
      'category_reimbursement_text': 'Reimbursement Kesehatan',
    },
    {
      'category_reimbursement_id': 2,
      'category_reimbursement_text': 'Reimbursement Transportasi',
    },
  ];

  //=========================== API TNC ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // ENDPOINT : edit-tnc-reimbursement ****************
  Map bodyEditTncReimbursemnet = {
    'list_category_tnc': [
      {
        'category_reimbursement_id': 1,
        'list_tnc': [
          'Klaim harus mencakup biaya pengobatan yang sah dan terkait langsung dengan kesehatan pribadi karyawan.',
          'Dokumen asli seperti faktur rumah sakit, resep dokter, dan kwitansi pembayaran harus disertakan dengan klaim.',
          'Pengajuan klaim harus diajukan dalam waktu 30 hari setelah pembayaran dilakukan.',
        ]
      },
      {
        'category_reimbursement_id': 2,
        'list_tnc': [
          'Biaya transportasi yang dapat diklaim termasuk perjalanan dinas, tiket pesawat, transportasi darat, dan sewa kendaraan.',
          'Klaim harus mencakup rincian perjalanan seperti tujuan, tanggal perjalanan, dan jumlah biaya yang dikeluarkan.',
          'Dokumen pendukung seperti tiket, kwitansi, atau bukti pembayaran harus dilampirkan bersama dengan formulir klaim.',
        ]
      }
    ]
  };
  Map responseEditTncReimbursement = {
    'is_success': true,
    'msg': 'Berhasil mengubah syarat dan ketentuan!',
  };

  // ENDPOINT : get-tnc-reimbursement ****************
  Map bodyGetTnchReimbursement = {};
  Map responseGetTncReimbursement = {
    'is_success': true,
    'msg': 'Edit Syarat dan Ketentuan Berhasil!',
    'data': [
      {
        'category_reimbursement_id': 1,
        'title': 'Kategori Kesehatan',
        'list_tnc': [
          'Klaim harus mencakup biaya pengobatan yang sah dan terkait langsung dengan kesehatan pribadi karyawan.',
          'Dokumen asli seperti faktur rumah sakit, resep dokter, dan kwitansi pembayaran harus disertakan dengan klaim.',
          'Pengajuan klaim harus diajukan dalam waktu 30 hari setelah pembayaran dilakukan.',
        ]
      },
      {
        'category_reimbursement_id': 2,
        'title': 'Kategori Transportasi',
        'list_tnc': [
          'Biaya transportasi yang dapat diklaim termasuk perjalanan dinas, tiket pesawat, transportasi darat, dan sewa kendaraan.',
          'Klaim harus mencakup rincian perjalanan seperti tujuan, tanggal perjalanan, dan jumlah biaya yang dikeluarkan.',
          'Dokumen pendukung seperti tiket, kwitansi, atau bukti pembayaran harus dilampirkan bersama dengan formulir klaim.',
        ]
      }
    ],
  };

  //=========================== API REIMBURSEMENT ================================

  // ENDPOINT : get-summary-home ****************
  Map bodyGetSummaryHome = {};
  Map responseGetSummaryHome = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': {
      'onproceed': 1,
      'accepted': 6,
      'rejected': 2,
      'total_reimburse_this_year': 200000,
      'limit_reimburse': 5000000,
    },
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

  // ENDPOINT : get-list-reimbursement ****************
  Map bodyGetListReimbursement = {
    'status_id': 1, //jika null mengembalikan semua data (tidak berdasarkan status)
  };
  Map responseGetListReimbursement = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': [
      {
        'id': 123,
        'status_id': 1,
        'status_text': 'Menunggu Diproses',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
      },
      {
        'id': 124,
        'status_id': 2,
        'status_text': 'Diproses',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
      },
      {
        'id': 125,
        'status_id': 3,
        'status_text': 'Disetujui',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
      },
      {
        'id': 126,
        'status_id': 3,
        'status_text': 'Ditolak',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
      },
    ],
  };

  // ENDPOINT : get-detail-reimbursement ****************
  Map responseGetDetailReimbursement = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': {
      'id': 126,
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
  };

  // ENDPOINT : post-submission ****************
  Map bodyPostSubmission = {
    'nik': '2010511068',
    'category_reimbursement_id': 1,
    'purpose_id': 20,
    'purpose_other_text': 'Sakit Pinggang/ meeting', //hanya jika Diagnosis lainnya terisi
    'total_cost': 400000,
    'list_attachment_base64': ['', '', ''],
    'list_detail': [
      {
        'detail_title_id': 1,
        'detail_title_other_text': '', //hanya jika rincian perawatan lainnya terisi
        'detail_family_id': 1, //hanya jika reimbursement kesehatan
        'detail_date': '10/07/2024',
        'detail_cost': 200000,
        'Keterangan': 'lorem ipsum',
      },
      {
        'detail_title_id': 1,
        'detail_title_other_text': '', //hanya jika rincian perawatan lainnya terisi
        'detail_family_id': 1, //hanya jika reimbursement kesehatan
        'detail_date': '10/07/2024',
        'detail_cost': 200000,
        'Keterangan': 'lorem ipsum',
      },
    ],
  };
  Map responsePostSubmission = {
    'is_success': true,
    'msg': 'Pengajuan reimbursement berhasil terkirim!',
  };

  //=========================== PROFILE ================================

  // role_id : 1 => Karyawan
  // role_id : 2 => Admin
  // role_id : 3 => HRD

  // family_status_id : 1 => Diri Sendiri
  // family_status_id : 2 => Suami
  // family_status_id : 3 => Istri
  // family_status_id : 4 => Anak

  // ENDPOINT : get-profile ****************
  Map bodyGetProfile = {};
  Map responseGetProfile = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': {
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
      ],
    },
  };

  // ENDPOINT : edit-profile ****************
  Map bodyEditProfile = {
    'name': 'Yudha Haryoputranto',
    'email': 'yudhah52@gmail.com',
    'nik': '2010511068',
    'image_base64': '',
    'family_member_data': [
      {'family_status_id': 1, 'family_status_text': 'Diri Sendiri', 'name': 'Yudha Haryoputranto'},
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
  Map responseEditProfile = {
    'is_success': true,
    'msg': 'Berhasil edit profil',
  };

  //=========================== NOTIFICATION ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // ENDPOINT : get-employee-notification ****************
  Map bodyGetEmployeeNotification = {};
  Map responseGetEmployeeNotification = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'status_id': 3,
        'status_text': 'Pengajuan Berhasil!',
        'status_desc': 'Pengajuan reimburse Anda berhasil, silakan cek saldo rekening Anda',
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
        'status_desc': 'Pengajuan reimburse Anda berhasil, silakan cek saldo rekening Anda',
      },
    ]
  };

  //=========================== RECAP ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // ENDPOINT : get-employee-year-recap ****************
  Map bodyGetEmployeeYearRecap = {};
  Map responseGetEmployeeYearRecap = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {'id': 24, 'year_text': '2023'},
      {'id': 23, 'year_text': '2024'},
    ],
  };

  // ENDPOINT : get-employee-month-recap ****************
  Map bodyGetEmployeeMonthRecap = {
    'year_id': 23,
  };
  Map responseGetEmployeeMonthRecap = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {'id': 523, 'month_text': 'Mei 2023'},
      {'id': 423, 'month_text': 'April 2023'},
      {'id': 323, 'month_text': 'Maret 2023'},
      {'id': 223, 'month_text': 'Februari 2023'},
      {'id': 123, 'month_text': 'Januari 2023'},
    ],
  };

  // ENDPOINT : get-employee-list-recap ****************
  Map bodyGetEmployeeListRecap = {
    'month_id': 523, // Dikosongkan jika ingin mengambil data pertahun
    'year_id': 23,
  };
  Map responseGetEmployeeListRecap = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
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
    ],
  };
}
