import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/features/classes/Logic/skills/cubit/skills_cubit.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';

import '../../../core/components/custom_app_bar.dart';
import 'widgets/level_button.dart';
import 'widgets/performance_card.dart';

class AnalyticsSkillsScreen extends StatelessWidget {
  const AnalyticsSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(title: 'Analytics'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                children: [
                  LevelSelector(
                    onLevelSelected: (_) {
                      context.read<SkillsCubit>().getEvaluationsbyLevelID(_);
                    },
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<SkillsCubit, SkillsState>(
                    builder: (context, state) {
                      if (state is SkillsLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is SkillsError) {
                        // Show error message if fetching fails
                        return Text('Error: ${state.error}');
                      } else if (state is EvaluationsLoaded) {
                        if (state.evaluations.isNotEmpty &&
                            state.evaluations[0].lessonEvaluations.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.evaluations.length,
                            itemBuilder: (context, builder) {
                              final evaluation = state.evaluations[builder];
                              return PerformanceCard(
                                title: evaluation.name,
                                icon: Icons.timer,
                                score: evaluation
                                    .lessonEvaluations[builder].score
                                    .toString(),
                              );
                            },
                          );
                        }
                        return NotFoundScreen();
                      } else {
                        return NotFoundScreen();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
