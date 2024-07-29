// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';

import '../../../../../api/shop/dtos/monster.dart';
import '../../../../../core/store_interface/main_store.dart';
import '../../../../../router/config.dart';
import '../../../../../utils/logger.dart';
import '../../../../../utils/utils.dart';
import '../widgets/food_modal.dart';

part 'monster_store.g.dart';

class MonsterStore = _MonsterStoreBase with _$MonsterStore;

abstract class _MonsterStoreBase extends MobxStore with Store {
  final ChildMonsterDto monster;

  _MonsterStoreBase({
    required this.monster,
  }){
    init();
  }

  final progressController = StreamController<double>();
  late VideoPlayerController monsterPlayerController;

  @observable
  int currentProgress = 0;

  @observable
  int currentMaxProgress = 0;

  @observable
  int currentStage = 0;

  @observable
  bool isStageDone = false;

  @action
  void setCurrentProgress(int value) => currentProgress = value;

  @action
  void setCurrentMaxProgress(int value) => currentMaxProgress = value;

  @action
  void setCurrentStage(int value) => currentStage = value;

  @action
  void setIsStageDone(bool value) => isStageDone = value;

  Future<void> addAction() async {

    if (isStageDone){
      await nextStage();
      return;
    }

    if (currentStage == 1){
      setCurrentProgress(currentProgress+1);
      updateProgress();
    }
    else if (currentStage == 2){
      setCurrentProgress(currentProgress+1);

      Navigator.of(Utils.context).pop();

      if (currentProgress == currentMaxProgress){
        await nextStage();
        return;
      }
      else{
        updateProgress();
      }
    }

    checkStage();

  }

  void updateProgress(){
    final percent = (currentProgress / currentMaxProgress) * 100;

    progressController.sink.add(percent);
  }

  void checkStage() => setIsStageDone(currentProgress == currentMaxProgress);

  Future<void> nextStage() async {
    progressController.sink.add(0);

    if (currentStage == 1){
      unawaited(loadAndStartMonsterVideo());
      setIsStageDone(false);
      setCurrentProgress(0);
      setCurrentMaxProgress(10);
      setCurrentStage(2);
    }
    else if (currentStage == 2){
      unawaited(loadAndStartMonsterVideo());
      setIsStageDone(false);
      setCurrentStage(3);
    }
  }
  
  Future<void> loadAndStartMonsterVideo() async {
    monsterPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(monster.monster?.monsterAttachment?.src ?? ''),
    );
    await monsterPlayerController.initialize();
    await monsterPlayerController.setLooping(true);
    await monsterPlayerController.play();
  }

  void openFoodModal() {
    showModalBottomSheet(
      context: Utils.context,
      barrierColor: Colors.transparent, 
      backgroundColor: Colors.transparent,
      builder: (_) => const FoodModalWidget(),
    );
  }

  Future<void> init() async {

    if (monster.brokenTimes < 3){
      setCurrentProgress(monster.brokenTimes);
      setCurrentMaxProgress(3);
      setCurrentStage(1);
    }
    else if (monster.timesFed < 10){
      unawaited(loadAndStartMonsterVideo());
      setCurrentProgress(monster.timesFed);
      setCurrentMaxProgress(10);
      setCurrentStage(2);
    }
    else{
      unawaited(loadAndStartMonsterVideo());
      setCurrentStage(3);
    }

  }

  @override
  void dispose() {
    progressController.close();
    try{
      monsterPlayerController.dispose();
    }
    catch(e,s){
      logger.handle(e,s);
    }
    super.dispose();
  }

}
