import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/store_widget.dart';
import '../../../../../core/const/colors.dart';
import '../../../../../core/utils/store_util.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../core/common/widgets/progress_line.dart';
import '../../domain/entities/course_child.dart';
import '../store/child_statistic_course_view_store.dart';
import '../widgets/course_block_item.dart';
import '../widgets/week_block.dart';

class CourseStatisticChildView extends HookWidget{
  final CourseChildEntity entity;
  const CourseStatisticChildView({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {

    final store = useMemoized(() => ChildStatisticCourseViewStore(entity));

    final course = entity.course;

    useEffect((){
      StoreUtil.registerStore(store);

      return () => StoreUtil.unregisterStore(store);
    }, [store],);

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
                      course.title,
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
                  course.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: ProjectColors.gray3,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            Observer(
              builder: (context) {
        
                var percent = 0.0;
        
                if (!store.loading.isLoading){
                  percent = store.courseDto.totalPercent;
                }
        
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h)
                    .copyWith(bottom: 10),
                  sliver: SliverToBoxAdapter(
                    child: ProgressLineWidget(progress: percent),
                  ),
                );
              },
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Observer(
                      builder: (context) {
        
                        var percent = 0.0;
        
                        if (!store.loading.isLoading){
                          percent = store.courseDto.totalPercent;
                        }
        
                        return Text(
                          '${percent.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: ProjectColors.gray4,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    Text(
                      '100%',
                      style: TextStyle(
                        color: ProjectColors.gray4,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              sliver: SliverToBoxAdapter(
                child: WeekBlockWidget(store: store,),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              sliver: SliverToBoxAdapter(
                child: Builder(
                  builder: (_){
                      return Text(
                        'Блоки',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: ProjectColors.gray1,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w)
                .copyWith(bottom: 50.h),
              sliver: Observer(
                builder: (_){
        
                  if (store.loading.isLoading){
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ProjectColors.main2,
                        ),
                      ),
                    );
                  }
        
                  if (store.courseDto.courseBlocks.isEmpty){
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'У курса нет блоков!',
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
                    return SliverList.separated(
                      itemBuilder: (_, index) => CourseBlockItemWidget(
                        block: store.courseDto.courseBlocks[index],
                      ), 
                      separatorBuilder: (_, __) => 20.heightBox,
                      itemCount: store.courseDto.courseBlocks.length,
                    );
                  }
                  // else if (store.courseDto.courseBlocks.length == 1){
                  //   final block = course.courseBlocks.first;
        
                  //   return SliverList.separated(
                  //     itemBuilder: (_, index) => LessonItemWidget(
                  //       lesson: block.lessons[index],
                  //       lessonNumber: index + 1,
                  //     ), 
                  //     separatorBuilder: (_, __) => SizedBox(height: 20.h,),
                  //     itemCount: block.lessons.length,
                  //   );
                  // }
                  // return SliverFillRemaining(
                  //   child: Center(
                  //     child: Text(
                  //       'Предметы пока не реализованны!',
                  //       style: TextStyle(
                  //         color: ProjectColors.gray4,
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
