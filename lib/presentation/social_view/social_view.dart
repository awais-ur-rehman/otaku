import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otaku/logic/social_cubit/social_cubit.dart';
import 'package:otaku/logic/social_cubit/social_states.dart';
import 'package:otaku/presentation/social_view/widgets/cstm_post_list.dart';
import 'package:otaku/presentation/social_view/widgets/error_view.dart';
import 'package:otaku/presentation/social_view/widgets/create_post_modal.dart';
import 'package:otaku/utils/colors/color.dart';
import '../../widgets/cstm_loader.dart';

class SocialView extends StatelessWidget {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    print("reload");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final socialCubit = context.read<SocialCubit>();
    socialCubit.fetchPosts();

    return Scaffold(
      backgroundColor: AppColors.black,
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryPurple,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.backgroundDark,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => const CreatePostModal(),
            );
          },
          child: Center(
            child: SvgPicture.asset(
              'assets/svgs/make-post.svg',
              height: screenWidth * 0.05,
              width: screenWidth * 0.05,
              color: AppColors.lightPurple,
            ),
          ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
        child: BlocBuilder<SocialCubit, SocialStates>(
          builder: (context, state) {
            if (state is SocialLoading) {
              return const Center(
                child: CustomLoader(loaderColor: AppColors.accentPurple),
              );
            } else if (state is SocialError) {
              return ErrorView(message: state.message);
            } else if (state is SocialEmpty) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              );
            } else if (state is SocialPostsLoaded) {
              return SafeArea(child: PostList(posts: state.posts));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
