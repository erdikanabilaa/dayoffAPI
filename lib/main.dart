import 'package:flutter/material.dart';

// Data API dari liburan tahun 2025
final List<Map<String, String>> holidays2025 = [
  {"tanggal": "01", "bulan": "Jan", "title": "Tahun Baru Masehi"},
  {"tanggal": "28", "bulan": "Jan", "title": "Isra Mi'raj Nabi Muhammad"},
  {"tanggal": "29", "bulan": "Jan", "title": "Tahun Baru Imlek"},
  {"tanggal": "01", "bulan": "Apr", "title": "Cuti Bersama Lebaran"},
  {"tanggal": "02", "bulan": "Apr", "title": "Cuti Bersama Lebaran"},
  {"tanggal": "18", "bulan": "Apr", "title": "Wafat Isa Almasih"},
  {"tanggal": "20", "bulan": "Apr", "title": "Hari Paskah"},
  {"tanggal": "01", "bulan": "Mei", "title": "Hari Buruh"},
  {"tanggal": "13", "bulan": "Mei", "title": "Hari Raya Waisak"},
  {"tanggal": "29", "bulan": "Mei", "title": "Kenaikan Isa Al Masih"},
  {"tanggal": "01", "bulan": "Jun", "title": "Hari Lahir Pancasila"},
  {"tanggal": "07", "bulan": "Jun", "title": "Idul Adha"},
  {"tanggal": "27", "bulan": "Jun", "title": "Tahun Baru Islam"},
  {
    "tanggal": "17",
    "bulan": "Agu",
    "title": "Hari Proklamasi Kemerdekaan R.I."
  },
  {"tanggal": "05", "bulan": "Sep", "title": "Maulid Nabi Muhammad SAW"},
  {"tanggal": "21", "bulan": "Okt", "title": "Diwali"},
  {"tanggal": "24", "bulan": "Des", "title": "Malam Natal"},
  {"tanggal": "25", "bulan": "Des", "title": "Hari Raya Natal"},
  {"tanggal": "31", "bulan": "Des", "title": "Malam Tahun Baru"},
];

// Fungsi untuk mengecek apakah suatu tanggal adalah libur
bool isHoliday(int day, int month) {
  return holidays2025.any((holiday) =>
      int.parse(holiday['tanggal']!) == day &&
      _monthToNumber(holiday['bulan']!) == month);
}

// Mendapatkan judul libur berdasarkan tanggal
String getHolidayDetail(int day, int month) {
  return holidays2025.firstWhere(
      (holiday) =>
          int.parse(holiday['tanggal']!) == day &&
          _monthToNumber(holiday['bulan']!) == month,
      orElse: () => {"title": "Tidak ada libur"})['title']!;
}

// Konversi nama bulan menjadi angka
int _monthToNumber(String month) {
  switch (month) {
    case "Jan":
      return 1;
    case "Feb":
      return 2;
    case "Mar":
      return 3;
    case "Apr":
      return 4;
    case "Mei":
      return 5;
    case "Jun":
      return 6;
    case "Jul":
      return 7;
    case "Agu":
      return 8;
    case "Sep":
      return 9;
    case "Okt":
      return 10;
    case "Nov":
      return 11;
    case "Des":
      return 12;
    default:
      return 0;
  }
}

// Konversi angka bulan menjadi nama bulan
String _monthToName(int month) {
  switch (month) {
    case 1:
      return "Januari";
    case 2:
      return "Februari";
    case 3:
      return "Maret";
    case 4:
      return "April";
    case 5:
      return "Mei";
    case 6:
      return "Juni";
    case 7:
      return "Juli";
    case 8:
      return "Agustus";
    case 9:
      return "September";
    case 10:
      return "Oktober";
    case 11:
      return "November";
    case 12:
      return "Desember";
    default:
      return "";
  }
}

// Widget Kalender
class HolidayCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalender 2025'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dua kolom per baris untuk bulan
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: 12, // 12 bulan
        itemBuilder: (context, index) {
          final month = index + 1;
          return MonthView(month: month);
        },
      ),
    );
  }
}

// Widget untuk menampilkan setiap bulan
class MonthView extends StatelessWidget {
  final int month;
  MonthView({required this.month});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _monthToName(month),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 7 hari dalam seminggu
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 31, // Mengasumsikan maksimal 31 hari
              itemBuilder: (context, index) {
                final day = index + 1;
                return GestureDetector(
                  onTap: () {
                    if (isHoliday(day, month)) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Detail Hari Libur'),
                            content: Text(getHolidayDetail(day, month)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: AspectRatio(
                    aspectRatio:
                        1, // Mengubah rasio aspek agar kotak lebih besar
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            isHoliday(day, month) ? Colors.red : Colors.white,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isHoliday(day, month)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 13, // Memperbesar ukuran teks
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: HolidayCalendar()));
