import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../api/user/dtos/user_children.dart';
import '../../../../../core/common/widgets/store_widget.dart';
import '../../../../../core/const/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../store/child_statistic_view_store.dart';
import '../widgets/course_view.dart';

class StatisticChildView extends HookWidget{
  final UserChildrenDto child;
  const StatisticChildView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final store = useMemoized(() => ChildStatisticViewStore(child));

    return Scaffold(
      backgroundColor: Colors.white,
      body: StoreWidget(
        store: store,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              pinned: true,
              floating: true,
              leading: IconButton(
                onPressed: context.pop,
                icon: ImageIcon(
                  Assets.images.arrowBack.image().image,
                  size: 24.h,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(44.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      child.name,
                      style: TextStyle(
                        color: ProjectColors.gray1,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Здесь Вы можете следить за прогрессом '
                  'и уровнем навыков ученика',
                  style: TextStyle(
                    color: ProjectColors.gray3,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            Observer(
              builder: (_){
                final courses = store.courses;
                if(store.loadingStore.isLoading){
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ProjectColors.main2,
                      ),
                    ),
                  );
                }
        
                if (courses.isEmpty){
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Курсы отсутствуют',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ProjectColors.gray4,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }
                else{
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 20.h,
                    ),
                    sliver: SliverList.separated(
                      itemBuilder: (_, index) => CourseViewWidget(
                        course: courses[index],
                      ), 
                      separatorBuilder: (_, __) => SizedBox(height: 20.h,),
                      itemCount: courses.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}
