import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/ui/views/home/tabs/widgets/personal_schedule_element_widget.dart';
import 'package:schedule/src/ui/views/home/tabs/widgets/personal_schedule_widget.dart';
import 'package:schedule/src/ui/views/home/tabs/widgets/school_schedule_element_widget.dart';
import 'package:schedule/src/ui/views/home/tabs/widgets/school_schedule_widget.dart';
import 'package:schedule/src/ui/views/loading_view.dart';
import 'package:schedule/src/ui/views/widgets_constants/spacing_box_widget.dart';
import 'package:schedule/src/utils/convert.dart';
import 'package:schedule/src/utils/utils.dart';

class ScheduleView extends StatelessWidget {
  final PageController _controller = PageController();

  Widget buildPageView() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScUtil.getInstance()!.setWidth(50),
          vertical: ScUtil.getInstance()!.setHeight(20)),
      alignment: Alignment.center,
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemBuilder: (BuildContext context, index) {
          return BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              if (state is UpdateScheduleDayLoadingState)
                return LoadingView();
              else if (state is UpdateScheduleDaySuccessState) {
                if (index == 0)
                  return SchoolScheduleWidget(state: state);
                else
                  return PersonalScheduleWidget(state: state);
              } else {
                return SizedBox();
              }
            },
          );
        },
        itemCount: 2,
      ),
    );
  }

  /*Widget buildExampleIndicatorWithShapeAndBottomPos(
      */ /*Shape shape,*/ /* double bottomPos) {
    return Positioned(
      bottom: bottomPos,
      left: 0,
      right: 0,
      child: WormIndicator(
        length: 2,
        controller: _controller,
        shape: shape,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    /* final circleShape = Shape(
      size: 8,
      shape: DotShape.Circle,
      spacing: 8,
    );*/
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildPageView(),
            //todo buildExampleIndicatorWithShapeAndBottomPos(circleShape, 8),
          ],
        ),
      ),
    );
  }







}
