import 'package:flutter/material.dart';

class Constant {
  static String randomImageUrl = 'https://picsum.photos/200';
  static String iconEmptyStateAsset = 'assets/empty_state/img-empty-state.png';

  static String imageErrorAsset = 'assets/empty_state/img-error.png';
  static String imageEmptyProfileAsset = 'assets/empty_state/img-empty-profile.png';

  static String imageRbCompany = 'assets/other/icon-rb-group.png';
  static String addressRbCompany =
      'Wirausaha Building 5th floor\nJl. HR. Rasuna Said Kav. C5 Jakarta 12940 Indonesia\nTelp. : +62 21 521 3590, Fax. : +62 21 521 3591 \nwww.rbgroup-jkt.com';

  static const Color greenDark = Color(0xFF004D34);
  static const Color greenMedium = const Color.fromRGBO(17, 143, 82, 1);
  static const Color green = Color(0xFF216600);
  static const Color greenLight = Color(0xFFC1FFC0);
  static const Color greenMoreLight = const Color.fromRGBO(190, 255, 224, 1);
  static const Color greenMoreVeryLight = Color(0xFFF6FFF5);

  static const Color grey = Color(0xFFA8A8A8);
  static const Color darkGrey = Color.fromARGB(255, 114, 114, 114);

  static const int employeeRoleId = 1;
  static const int adminRoleId = 2;
  static const int hrdRoleId = 3;

  static const int selfStatusId = 1;
  static const int wifeStatusId = 2;
  static const int husbandStatusId = 3;
  static const int childStatusId = 4;

  static const int waitingStatusId = 1;
  static const int processStatusId = 2;
  static const int acceptedStatusId = 3;
  static const int rejectedStatusId = 4;

  static const String waitingStatusAsset = 'assets/status/icon-status-waiting.png';
  static const String processStatusAsset = 'assets/status/icon-status-process.png';
  static const String acceptedStatusAsset = 'assets/status/icon-status-succeed.png';
  static const String rejectedStatusAsset = 'assets/status/icon-status-failed.png';

  static const int healthCategoryReimbursementId = 1;
  static const int transportCategoryReimbursementId = 2;

  static const int homeMenuIndex = 0;
  static const int reimburseMenuindex = 1;
  static const int notificationMenuIndex = 2;
  static const int profileMenuIndex = 3;

  static const Color waitingStatusColor = Color(0xFFFFC107);
  static const Color processStatusIconColor = Color(0xFF0021F5);
  static const Color processStatusTextColor = Color(0xFF020064);
  static const Color acceptedStatusIconColor = Color(0xFF13EC00);
  static const Color acceptedStatusTextColor = Color(0xFF134A00);
  static const Color rejectedStatusColor = Color(0xFFEB3223);
  static const Color limitColor = Colors.deepOrange;

  static const FontWeight extraBoldText = FontWeight.w800;
  static const FontWeight boldText = FontWeight.w700;
  static const FontWeight semiBoldText = FontWeight.w600;
  static const FontWeight mediumWeightText = FontWeight.w500;
  static const FontWeight normalWeightText = FontWeight.w400;
  static const FontWeight lightWeightText = FontWeight.w300;
  static const FontWeight extraLightWeightText = FontWeight.w200;

  static const String defaultErrorMessage = 'Terjadi kesahalan!';
  static const String confirmUnsavedAlertClose =
      'Apakah Anda yakin akan keluar dari halaman ini? Perubahan tidak akan disimpan.';
  static const String warningPasswordMatchString = 'Password tidak cocok';
  static const String infoFormDetailCost =
      'Mohon inputkan biaya penggantian sesuai dengan detail perawatan yang tertera pada kuitansi.';
  static const String noteFormPurposeHealth =
      'Catatan : Masukkan Diagnosis lainnya hanya jika tidak terdapat di dalam opsi.';
  static const String noteFormPurposeTransport =
      'Catatan : Masukkan Tujuan Perjalanan lainnya hanya jika tidak terdapat di dalam opsi.';
  static const String noteFormDetailTitle =
      'Catatan : Masukkan rincian perjalanan lainnya hanya jika tidak terdapat di dalam opsi.';
  static const String noteFormDateDetailTitle =
      'Catatan : Kuitansi harus bertanggal tidak lebih dari satu bulan yang lalu.';
  static const String warningFormIncomplete = 'Gagal Unggah! Mohon lengkapi formulir pengajuan';
  static const String warningUnverifiedEmployeeAccount =
      'Akun Anda belum diverifikasi oleh Admin. Mohon tunggu sebelum Anda dapat melakukan pengajuan';
  static const String warningUnverifiedAdminAccount =
      'Akun Anda belum diverifikasi oleh Admin. Mohon tunggu sebelum Anda dapat mengelola permintaan';

  static const TextStyle regularNoteStyle = TextStyle(
    color: greenDark,
    fontWeight: lightWeightText,
    fontSize: 12,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle warningNoteStyle = TextStyle(
    color: rejectedStatusColor,
    fontWeight: lightWeightText,
    fontSize: 12,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle mainTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: boldText,
  );
  static const TextStyle secondTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: boldText,
  );

  static const TextStyle unselectedDropdownItemStyle = TextStyle(
    fontSize: 16,
    color: grey,
    fontWeight: lightWeightText,
  );
  static const TextStyle selectedDropdownItemStyle = TextStyle(
    fontSize: 16,
  );
}
