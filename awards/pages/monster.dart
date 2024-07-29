import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inkbutton/inkbutton.dart';

import '../../../../../api/shop/dtos/monster.dart';
import '../../../../../core/common/widgets/store_widget.dart';
import '../../../../../core/utils/store_util.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/child_mode/star_icon.dart';
import '../../../../../widgets/progress_line/progress_line.dart';
import '../store/monster_store.dart';
import '../widgets/adult_monster.dart';
import '../widgets/break_stage.dart';
import '../widgets/feed_stage.dart';

class MonsterPage extends HookWidget {
  final ChildMonsterDto monster;
  const MonsterPage({super.key, required this.monster});

  @override
  Widget build(BuildContext context) {

    final store = useMemoized(() => MonsterStore(monster: monster));

    useEffect((){
      StoreUtil.registerStore(store);

      return () => StoreUtil.unregisterStore(store);
    }, [store],);

    return Scaffold(
      backgroundColor: Colors.white,
      body: StoreWidget(
        store: store,
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                leading: InkButton(
                  splashAnimation: false,
                  onClick: context.pop,
                  child: SizedBox.square(
                    dimension: 26,
                    child: Center(
                      child: Assets.images.arrowBack.image(
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ),
                ),
                flexibleSpace: Row(
                  children: [
                    Observer(
                      builder: (context) {
                        if (store.currentStage == 3){
                          return const SizedBox().expanded();
                        }
                        return ProgressLineHookedWidget(
                          progress: 0,
                          progressStream: store.progressController.stream,
                          height: 16,
                          child: Observer(
                            builder: (context) {
                              return Text(
                                '${store.currentProgress}/${store.currentMaxProgress}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ).expanded();
                      },
                    ),
                    const StarIcon(),
                  ],
                )
                  .paddingSymmetric(horizontal: 10.w)
                  .paddingOnly(top: 50, left: 50),
            ),
          ],
          body: Observer(
            builder: (context){
              return switch(store.currentStage){
                1 => const BreakStageWidget(),
                2 => const FeedStageWidget(),
                3 => const AdultMonsterWidget(),
                _ => const SizedBox(),
              };
            },
          ),
        ),
      ),
    );
  }
}
