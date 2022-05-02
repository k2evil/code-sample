import 'dart:convert';

import 'package:digisina/features/home/data/model/home_parts.dart';
import 'package:dio/dio.dart';
import 'package:time/time.dart';

abstract class HomePageRemoteDataSource {
  Future<HomePageParts> getHomePageParts();
}

class HomePageRemoteMockDataSource extends HomePageRemoteDataSource {
  @override
  Future<HomePageParts> getHomePageParts() {
    const json =
        "{\"slides\":[{\"id\":0,\"image_url\":\"https://dam.krohne.com/t_ar43_cr_c//e_trim:0/w_700/q_auto/dpr_3.0/f_auto/d_im-other:image-not-available.png/im-contract-photography/orange-black-loaded-container-ship-harbour.jpg\",\"link\":\"www.google.com\"},{\"id\":1,\"image_url\":\"https://media.mehrnews.com/d/2016/04/26/3/2060498.jpg\",\"link\":\"www.google.com\"},{\"id\":2,\"image_url\":\"https://icelet2019.kntu.ac.ir/editor_file/image/IMG_0951.jpg\",\"link\":\"www.google.com\"}],\"calendar\":{\"day_string\":\"شنبه 19 بهمن 1400\",\"day_message\":\"روز ملی حمل و نقل کشتی رانی\"},\"options\":[{\"title\":\"پیام‌رسان\",\"icon_url\":\"https://www.alborzpm.ir/message.svg\",\"alias\":\"messaging\",\"enabled\":true},{\"title\":\"نظرسنجی\",\"icon_url\":\"https://www.alborzpm.ir/poll.svg\",\"alias\":\"poll\",\"enabled\":true},{\"title\":\"فیش حقوقی\",\"icon_url\":\"https://www.alborzpm.ir/documents.svg\",\"alias\":\"payroll\",\"enabled\":true},{\"title\":\"درخواست وام\",\"icon_url\":\"https://www.alborzpm.ir/debt.svg\",\"alias\":\"loan_request\",\"enabled\":true},{\"title\":\"حکم کارگزینی\",\"icon_url\":\"https://www.alborzpm.ir/kargozini.svg\",\"alias\":\"ordinance\",\"enabled\":true},{\"title\":\"کنترل پروژه\",\"icon_url\":\"https://www.alborzpm.ir/dashboard.svg\",\"alias\":\"project_controll\",\"enabled\":true}],\"latest_blogs\":[{\"image_url\":\"https://res.cloudinary.com/fourcare/image/upload/s--uGXqHOwF--/v1583426500/sunset-index/header-bg_1.jpg\",\"title\":\"عنوان مطلب\",\"content\":\"لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ می باشد\",\"id\":10},{\"image_url\":\"https://www.jamesedition.com/stories/wp-content/uploads/2020/12/1_Israel.jpg\",\"title\":\"عنوان مطلب\",\"content\":\"لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ می باشد\",\"id\":11},{\"image_url\":\"https://sazechi.ir/wp-content/uploads/2020/07/%D8%B4%DB%8C%D8%B4%D9%87-%D9%85%D8%B3%D8%AC%D8%AF-%D9%86%D8%B5%DB%8C%D8%B1%D8%A7%D9%84%D9%85%D9%84%DA%A9-3-900x600.jpg\",\"title\":\"عنوان مطلب\",\"content\":\"لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ می باشد\",\"id\":12}]}";
    final model = HomePageParts.fromJson(jsonDecode(json));
    return Future.delayed(2000.milliseconds, () => model);
  }
}

class IHomePageRemoteDataSource extends HomePageRemoteDataSource {
  final Dio dio;

  IHomePageRemoteDataSource({required this.dio});

  @override
  Future<HomePageParts> getHomePageParts() async {
    var response = await dio.get("/v1/home");
    return HomePageParts.fromJson(response.data);
  }
}
