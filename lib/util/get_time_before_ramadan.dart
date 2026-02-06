import 'package:hijri/hijri_calendar.dart';

Duration getTimeBeforeRamadan() {
  final now = DateTime.now();

  final todayHijri = HijriCalendar.fromDate(now);

  int ramadanYear = todayHijri.hYear;
  if (todayHijri.hMonth > 9 || (todayHijri.hMonth == 9 && todayHijri.hDay >= 1)) {
    ramadanYear += 1;
  }

  final ramadanHijri = HijriCalendar()
    ..hYear = ramadanYear
    ..hMonth = 9
    ..hDay = 1;

  final ramadanGregorian = ramadanHijri.hijriToGregorian(
    ramadanHijri.hYear,
    ramadanHijri.hMonth,
    ramadanHijri.hDay,
  );

  final remaining = ramadanGregorian.difference(now);

  return remaining.isNegative ? Duration.zero : remaining;
}
