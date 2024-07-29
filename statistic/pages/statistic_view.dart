import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/const/colors.dart';
import '../../../../../store/create_first_child/create_first_child_state.dart';
import '../widgets/child_view.dart';

class StatisticView extends HookWidget {
  const StatisticView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Успехи учеников',
                style: TextStyle(
                  color: ProjectColors.gray1,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w,),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Здесь Вы можете следить за прогрессом и '
                'уровнем навыков учеников',
                style: TextStyle(
                  color: ProjectColors.gray3,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w, vertical: 20.h,
            ).copyWith(bottom: 0),
            sliver: SliverList.separated(
              itemBuilder: (_, index) =>
                ChildViewWidget(
                  child: CreateFirstChildStore.children[index],
                ), 
              separatorBuilder: (_, __) => SizedBox(height: 20.h,),
              itemCount: CreateFirstChildStore.children.length,
            ),
          ),
        ],
      ),
    );
  }
}
