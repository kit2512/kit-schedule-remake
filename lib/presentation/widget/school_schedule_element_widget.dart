import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/presentation/themes/theme_border.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/widgets_constants.dart';

class SchoolScheduleElementWidget extends StatelessWidget {
  final SchoolSchedule schedule;

  SchoolScheduleElementWidget({required this.schedule});

  @override
  Widget build(BuildContext context) {
    List lessonNumbers = schedule.lesson!.split(',');
    String startLesson = lessonNumbers[0];
    String endLesson = lessonNumbers[lessonNumbers.length - 1];
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: WidgetsConstants.cardMargin,
          horizontal: WidgetsConstants.cardMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${Convert.startTimeLessonMap[startLesson]}',
                      style: ThemeText.textStyle
                          .copyWith(color: AppColor.scheduleType)),
                  Icon(Icons.arrow_drop_down,
                      color: AppColor.scheduleType,
                      size: ScreenUtil().setHeight(15)),
                  Text('${Convert.endTimeLessonMap[endLesson]}',
                      style: ThemeText.textStyle
                          .copyWith(color: AppColor.scheduleType)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: WidgetsConstants.detailColumnPaddingHorizontal),
              decoration: BoxDecoration(
                  border: Border(
                      left: ThemeBorder.scheduleElementBorder
                          .copyWith(color: AppColor.scheduleType))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${schedule.subject}',
                      style: ThemeText.textStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.scheduleType)),
                  Text(
                      schedule.address!.contains('null')
                          ? WidgetsConstants.noDataTxt
                          : '${schedule.address}',
                      style: ThemeText.textStyle
                          .copyWith(color: AppColor.scheduleType)
                          .copyWith(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
