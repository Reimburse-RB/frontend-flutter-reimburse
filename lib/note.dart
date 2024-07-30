class Note {
  // cache key name in local storage
  // authToken => auth-token
  // role => role

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
  // ROLE : ADMIN & HRD
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
  // ROLE : ALL USER
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

  //=========================== API FORM ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // ENDPOINT : get-list-purpose-option ****************
  // ROLE : EMPLOYEE
  Map bodyGetListPurposeOption = {
    'category_reimbursement': 1,
  };
  Map responseGetListPurposeOption = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': [
      {
        'purpose_id': 1,
        'purpose_text': 'Flu Batuk',
      },
      {
        'purpose_id': 2,
        'purpose_text': 'Demam',
      },
      {
        'purpose_id': 3,
        'purpose_text': 'Masuk Angin',
      },
      {
        'purpose_id': 4,
        'purpose_text': 'Lainnya',
      },
    ],
  };

  // ENDPOINT : get-list-detail-title-option ****************
  // ROLE : EMPLOYEE
  Map bodyGetListDetailTitleOption = {
    'category_reimbursement': 1,
  };
  Map responseGetListDetailTitleOption = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': [
      {
        'detail_title_id': 1,
        'detail_title_text': 'Konsultasi Dokter',
      },
      {
        'detail_title_id': 2,
        'detail_title_text': 'Resep',
      },
      {
        'detail_title_id': 3,
        'detail_title_text': 'Obat-obatan',
      },
      {
        'detail_title_id': 4,
        'detail_title_text': 'Lainnya',
      },
    ],
  };

  //=========================== API REIMBURSEMENT ================================

  // ENDPOINT : get-employee-summary ****************
  // ROLE : EMPLOYEE
  Map bodyGetEmployeeSummary = {};
  Map responseGetEmployeeSummary = {
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

  // ENDPOINT : get-current-active-request ****************
  // ROLE : ADMIN & HRD
  Map bodyGetCurrentActiveRequest = {};
  Map responseGenCurrentActiveRequest = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': {
      'waiting_and_onprocess': 4,
      'healt_waiting_and_onprocess': 2,
      'transport_waiting_and_onprocess': 2,
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

  // ENDPOINT : post-submission ****************
  // ROLE : EMPLOYEE
  Map bodyPostSubmission = {
    'nik': 2010511068,
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
    'data': {
      'id': 123,
    }
  };

  // ENDPOINT : cancel-submission ****************
  // ROLE : EMPLOYEE
  Map bodyCancelSubmission = {
    'id': 126,
  };
  Map responseCancelSubmission = {
    'is_success': true,
    'msg': 'Pengajuan reimbursement berhasil dibatalkan!',
  };

  // ENDPOINT : get-list-reimbursement ****************
  // ROLE : ALL USER
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
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
      {
        'id': 124,
        'status_id': 2,
        'status_text': 'Diproses',
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
      {
        'id': 125,
        'status_id': 3,
        'status_text': 'Disetujui',
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
      {
        'id': 126,
        'status_id': 3,
        'status_text': 'Ditolak',
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
    ],
  };

  // ENDPOINT : get-detail-reimbursement ****************
  // ROLE : ALL USER
  Map bodyGetDetailReimbursement = {
    'id': 126,
  };
  Map responseGetDetailReimbursement = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': {
      'id': 126,
      'status_id': 1,
      'status_text': 'Menunggu Diproses',
      'status_desc': 'Dokumen Tidak Valid', //HANYA JIKA statusnya DISETUJUI DAN DITOLAK
      'nik': 2010511068,
      'email': 'yudhah52@gmail.com',
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
          'detail_id': 146,
          'detail_title_id': 1,
          'detail_title_text': 'Konsultasi Dokter',
          'detail_family_id': 3,
          'detail_family_name': 'Freya Jayawardana',
          'detail_date': '10/07/2024',
          'detail_cost': 200000,
          'detail_desc': 'lorem ipsum'
        },
        {
          'detail_id': 146,
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

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // ENDPOINT : change-status-reimbursement ****************
  // ROLE : ADMIN & HRD
  Map bodyChangeStatusReimbursement = {
    'id': 126,
    'change_status_id': 2,
    'status_desc': 'Pengajuan Sedang Diproses',
  };
  Map responseChangeStatusReimbursement = {
    'is_success': true,
    'msg': 'Berhasil mengubah status',
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
  // ROLE : ALL USER
  Map bodyGetProfile = {};
  Map responseGetProfile = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': {
      'nik': 2010511068,
      'name': 'Yudha Haryoputranto',
      'email': 'yudhah52@gmail.com',
      'img_url':
          'https://media.licdn.com/dms/image/C5603AQFOfZiG507GCg/profile-displayphoto-shrink_800_800/0/1644315854486?e=1725494400&v=beta&t=AEKapy2te-iNY6J4Qz4NpHgllXpQdQVWV26YBBOAaWM',
      'role_id': 1,
      'role_text': 'Karyawan',
      'family_member_data': [
        {
          'id': 23143,
          'family_status_id': 1,
          'family_status_text': 'Diri Sendiri',
          'name': 'Yudha Haryoputranto'
        },
        {
          'id': 2132,
          'family_status_id': 3,
          'family_status_text': 'Istri',
          'name': 'Freya Jayawardana',
        },
        {
          'id': 21343,
          'family_status_id': 4,
          'family_status_text': 'Anak',
          'name': 'Yhezra',
        },
      ],
    },
  };

  // ENDPOINT : edit-profile ****************
  // ROLE : ALL USER
  // NOTE : Hanya memasukkan data yang berubah saja pada body, yg tidak berubah null
  Map bodyEditProfile = {
    'nik': 2010511068, // not editable
    'name': 'Yudha Haryoputranto',
    'email': 'yudhah52@gmail.com',
    'image_base64': '',
    'family_member_data': [
      {
        'id': 23143,
        'family_status_id': 1, // not editable
        'family_status_text': 'Diri Sendiri', // not editable
        'name': 'Yudha Haryoputranto', // not editable
      },
      {
        'id': 2132,
        'family_status_id': 3,
        'family_status_text': 'Istri',
        'name': 'Freya Jayawardana',
      },
      {
        'id': 21343,
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

  //=========================== ACCOUNT VERIFICATION ================================
  // role_id : 1 => Karyawan
  // role_id : 2 => Admin
  // role_id : 3 => HRD

  // account_verif_category_id : 1 => Akun Baru
  // account_verif_category_id : 2 => Perubahan Akun

  // family_status_id : 1 => Diri Sendiri
  // family_status_id : 2 => Suami
  // family_status_id : 3 => Istri
  // family_status_id : 4 => Anak

  // ENDPOINT : get-list-account-verification ****************
  // ROLE : ADMIN & HRD
  Map bodyGetListAccountVerification = {};
  Map responseGetListAccountVerification = {
    'is_success': true,
    'msg': 'Berhasil',
    'data': [
      {
        'nik': 2010511068,
        'account_verif_category_id': 1,
        'account_verif_category_text': 'Akun Baru',
        'name': 'Yudha Haryoputranto',
        'email': 'yudhah52@gmail.com',
        'img_url':
            'https://media.licdn.com/dms/image/C5603AQFOfZiG507GCg/profile-displayphoto-shrink_800_800/0/1644315854486?e=1725494400&v=beta&t=AEKapy2te-iNY6J4Qz4NpHgllXpQdQVWV26YBBOAaWM',
        'role_id': 1,
        'role_text': 'Karyawan',
        'family_member_data': [
          {
            'id': 23143,
            'family_status_id': 1,
            'family_status_text': 'Diri Sendiri',
            'name': 'Yudha Haryoputranto'
          },
          {
            'id': 2132,
            'family_status_id': 3,
            'family_status_text': 'Istri',
            'name': 'Freya Jayawardana',
          },
          {
            'id': 21343,
            'family_status_id': 4,
            'family_status_text': 'Anak',
            'name': 'Yhezra',
          },
        ],
      }
    ],
  };

  // ENDPOINT : confirm-account-verification ****************
  // ROLE : ADMIN & HRD
  Map bodyConfirmAccountVerification = {
    'nik': 2010511068,
    'account_verif_category_id': 1,
    'is_accept': false, // true diterima
    'confirm_desc': 'Perubahan Tidak Valid',
  };
  Map responseConfirmAccountVerification = {
    'is_success': true,
    'msg': 'Berhasil mengonfirmasi verifikasi akun',
  };

  //=========================== NOTIFICATION ================================

  // category_reimbursement : 1 => Reimbursement Kesehatan
  // category_reimbursement : 2 => Reimbursement Transportasi

  // status_id = 1 => Menunggu diproses
  // status_id = 2 => Diproses
  // status_id = 3 => Disetujui
  // status_id = 4 => Ditolak

  // ENDPOINT : get-employee-notification ****************
  // ROLE : EMPLOYEE
  Map bodyGetEmployeeNotification = {};
  Map responseGetEmployeeNotification = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {
        'id': 126,
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'status_id': 3,
        'status_text': 'Pengajuan Berhasil!',
        'status_desc': 'Pengajuan reimburse Anda berhasil, silakan cek saldo rekening Anda',
      },
      {
        'id': 126,
        'category_reimbursement': 2,
        'category_reimbursement_text': 'Reimbursement Transportasi',
        'date': '21/07/2024',
        'status_id': 4,
        'status_text': 'Pengajuan Gagal!',
        'status_desc':
            'Pengajuan reimburse Anda gagal, silakan cek kembali dokumen terlampir yang tidak valid',
      },
      {
        'id': 126,
        'category_reimbursement': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'status_id': 3,
        'status_text': 'Pengajuan Berhasil!',
        'status_desc': 'Pengajuan reimburse Anda berhasil, silakan cek saldo rekening Anda',
      },
    ]
  };

  // ENDPOINT : get-admin-notification ****************
  // ROLE : ADMIN & HRD
  Map bodyGetAdminNotification = {};
  Map responseGetAdminNotification = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {
        'id': 123,
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
      {
        'id': 124,
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
      {
        'id': 125,
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
      },
      {
        'id': 126,
        'nik': 2010511068,
        'name': 'Yudha Haryoputranto',
        'category_reimbursement_id': 1,
        'category_reimbursement_text': 'Reimbursement Kesehatan',
        'date': '21/07/2024',
        'total_cost': 400000,
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

  // ENDPOINT : get-year-recap ****************
  // ROLE : ALL USER
  Map bodyGetYearRecap = {};
  Map responseGetYearRecap = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {'id': 24, 'year_text': '2023'},
      {'id': 23, 'year_text': '2024'},
    ],
  };

  // ENDPOINT : get-month-recap ****************
  // ROLE : ALL USER
  Map bodyGetMonthRecap = {
    'year_id': 23,
  };
  Map responseGetMonthRecap = {
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

  // ENDPOINT : get-list-recap ****************
  // ROLE : ALL USER
  Map bodyGetEmployeeListRecap = {
    'month_id': 523, // Dikosongkan jika ingin mengambil data pertahun
    'year_id': 23,
  };
  Map responseGetEmployeeListRecap = {
    'is_success': true,
    'msg': 'Berhasil!',
    'data': [
      {
        'id': 126,
        'status_id': 1,
        'status_text': 'Menunggu Diproses',
        'status_desc': 'Dokumen Tidak Valid', //HANYA JIKA statusnya DISETUJUI DAN DITOLAK
        'nik': 2010511068,
        'email': 'yudhah52@gmail.com',
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
            'detail_id': 146,
            'detail_title_id': 1,
            'detail_title_text': 'Konsultasi Dokter',
            'detail_family_id': 3,
            'detail_family_name': 'Freya Jayawardana',
            'detail_date': '10/07/2024',
            'detail_cost': 200000,
            'detail_desc': 'lorem ipsum'
          },
          {
            'detail_id': 146,
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
        'id': 128,
        'status_id': 1,
        'status_text': 'Menunggu Diproses',
        'status_desc': 'Dokumen Tidak Valid', //HANYA JIKA statusnya DISETUJUI DAN DITOLAK
        'nik': 2010511068,
        'email': 'yudhah52@gmail.com',
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
            'detail_id': 146,
            'detail_title_id': 1,
            'detail_title_text': 'Konsultasi Dokter',
            'detail_family_id': 3,
            'detail_family_name': 'Freya Jayawardana',
            'detail_date': '10/07/2024',
            'detail_cost': 200000,
            'detail_desc': 'lorem ipsum'
          },
          {
            'detail_id': 146,
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
