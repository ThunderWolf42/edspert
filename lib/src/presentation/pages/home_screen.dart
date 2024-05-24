import 'package:edspert/src/core/constants/color_constants.dart';
import 'package:edspert/src/core/constants/string_constants.dart';
import 'package:edspert/src/domain/entitites/banner_entity.dart';
import 'package:edspert/src/domain/usecases/get_banner_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data.dart';
import '../manager/banner/banner_bloc.dart';
import '../manager/course/course_bloc.dart';
import '../widgets/course_list_widget.dart';
import '../widgets/image_network_widget.dart';
import 'all_course_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseBloc(courseRepository: CourseRepositoryImpl())..add(GetCourseEvent()),
        ),
        BlocProvider(
          create: (context) => BannerBloc(
            GetBannerListUsecase(
              BannerRepositoryImpl(
                BannerDataSource(),
              ),
            ),
          )..add(GetBannerEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorConstants.greyBackground,
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hai, Darrel',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(radius: 16),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 147,
                  decoration: BoxDecoration(
                    color: ColorConstants.edspertBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 26, left: 20),
                          child: Text(
                            'Mau kerjain\nlatihan soal\napa hari ini?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset('images/homePage_logo.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              Strings.pilihPelajaran,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (state is CourseSuccess) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllCourseListScreen(
                                          courseList: state.courseList,
                                        ),
                                      ));
                                }
                              },
                              child: const Text('Lihat Semua'),
                            )
                          ],
                        ),
                        if (state is CourseSuccess)
                          _buildCourseListWidget(state.courseList)
                        else
                          const CircularProgressIndicator(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 27),
                BlocBuilder<BannerBloc, BannerState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Terbaru',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (state is BannerSuccess)
                          _buildBannerListWidget(state.bannerList)
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerListWidget(List<BannerEntity> bannerList) {
    return SizedBox(
      height: 146,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final banner = bannerList[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImageNetworkWidget(
              imageUrl: banner.imageUrl,
              height: 146,
              width: 284,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: bannerList.length,
      ),
    );
  }

  Widget _buildCourseListWidget(List<CourseData> courseList) {
    final courseCount = courseList.length > 3 ? 3 : courseList.length;

    return courseList.isEmpty
        ? const CircularProgressIndicator()
        : CourseListWidget(
            itemCount: courseCount,
            courseList: courseList,
          );
  }
}
