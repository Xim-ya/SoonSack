/* Created By Ximya - 2022.11.04
*  Single Imports로 패키지 및 소스파일 관리
*  TODO: 중복된 export 구문 있음. 삭제 필요
* */

// Flutter Packages
export 'package:flutter/material.dart';
export 'package:flutter/rendering.dart';
export 'package:flutter_svg/svg.dart';
export 'dart:async';
export 'package:flutter/services.dart';


// External Packages
export 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
export 'package:get/get.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:shimmer_animation/shimmer_animation.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:youtube_explode_dart/youtube_explode_dart.dart';
export 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
export 'package:firebase_auth/firebase_auth.dart';


// BaseModule
export 'package:soon_sak/presentation/base/base_view_model.dart';
export 'package:soon_sak/domain/base/base_use_case.dart';
export 'package:soon_sak/domain/base/base_no_param_use_case.dart';
export 'package:soon_sak/domain/base/base_two_param_use_case.dart';

// App
export 'package:soon_sak/data/dto/tmdb/response/newResponse/tmdb_movie_content_list_wrapped_response.dart';
export 'package:soon_sak/data/dto/tmdb/response/newResponse/tmdb_tv_content_list_wrapped_response.dart';
export 'package:soon_sak/app/config/font_config.dart';
export 'package:soon_sak/app/config/color_config.dart';
export 'package:soon_sak/app/routes/app_routes.dart';
export 'package:soon_sak/app/config/app_space_config.dart';
export 'package:soon_sak/app/config/size_config.dart';
export 'package:soon_sak/app/modules/data_modules.dart';
export 'package:soon_sak/app/modules/domain_modules.dart';
export 'package:soon_sak/app/modules/presentation_modules.dart';

// Data
export 'package:soon_sak/data/dto/staticContent/response/category_content_collection_response.dart';
export 'package:soon_sak/data/dataSource/staticContent/static_content_data_source.dart';
export 'package:soon_sak/data/dto/staticContent/static_content_api.dart';
export 'package:soon_sak/data/repository/youtube/youtube_repository.dart';
export 'package:soon_sak/data/dto/tmdb/response/newResponse/tmdb_content_credit_response.dart';
export 'package:soon_sak/data/dto/tmdb/response/newResponse/tmdb_tv_detail_response.dart';
export 'package:soon_sak/data/dto/tmdb/tmdb_api.dart';
export 'package:soon_sak/data/dto/tmdb/response/newResponse/tmdb_movie_detail_response.dart';
export 'package:soon_sak/data/dto/tmdb/response/newResponse/tmdb_content_image_response.dart';
export 'package:soon_sak/data/dataSource/content/content_data_source.dart';
export 'package:soon_sak/data/dataSource/content/content_data_source_impl.dart';
export 'package:soon_sak/data/dataSource/tmdb/tmdb_data_source.dart';
export 'package:soon_sak/data/dataSource/tmdb/tmdb_data_source_impl.dart';
export 'package:soon_sak/data/repository/content/content_repository.dart';
export 'package:soon_sak/data/repository/content/content_repository_impl.dart';
export 'package:soon_sak/data/repository/tmdb/tmdb_repository.dart';
export 'package:soon_sak/data/repository/tmdb/tmdb_repository_impl.dart';
export 'package:soon_sak/data/dto/staticContent/response/banner_response.dart';
export 'package:soon_sak/data/repository/staticContent/static_content_repository.dart';
export 'package:soon_sak/data/dto/staticContent/response/top_ten_content_response.dart';
export 'package:soon_sak/data/mixin/fire_store_error_handler_mixin.dart';

// Domain
export 'package:soon_sak/domain/model/content/home/banner_model.dart';
export 'package:soon_sak/domain/service/local_storage_service.dart';
export 'package:soon_sak/domain/useCase/content/load_cached_banner_content_use_case.dart';
export 'package:soon_sak/domain/useCase/search/search_validate_url_use_case.dart';
export 'package:soon_sak/domain/mixin/paging_handler_mixin.dart';
export 'package:soon_sak/domain/mixin/search_handler_mixin.dart';
export 'package:soon_sak/domain/model/content/content.dart';
export 'package:soon_sak/domain/useCase/search/search_paged_content_use_case.dart';
export 'package:soon_sak/domain/enum/validation_state_enum.dart';
export 'package:soon_sak/domain/useCase/explore/load_explore_content_by_slider_index_use_case.dart';
export 'package:soon_sak/domain/useCase/explore/partial_load_content_use_case.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content_detail_info.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content_youtube_info.dart';
export 'package:soon_sak/domain/model/content/explore_content_id_info.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content.dart';
export 'package:soon_sak/domain/model/content/season_info.dart';
export 'package:soon_sak/domain/model/video/content_videos.dart';
export 'package:soon_sak/domain/enum/content_video_format.dart';
export 'package:soon_sak/domain/useCase/video/load_content_of_video_list_use_case.dart';
export 'package:soon_sak/domain/model/video/content_video_item.dart';
export 'package:soon_sak/domain/model/content/content_shell.dart';
export 'package:soon_sak/domain/model/content/simple_content_info.dart';
export 'package:soon_sak/domain/enum/content_type_enum.dart';
export 'package:soon_sak/domain/model/youtube/youtube_content_comment.dart';
export 'package:soon_sak/domain/model/youtube/youtube_video_content_info.dart';
export 'package:soon_sak/domain/model/content/tv_content_credit_info.dart';
export 'package:soon_sak/domain/model/content/content_episode_info_item.dart';
export 'package:soon_sak/domain/useCase/tmdb/load_content_detail_info_use_case.dart';
export 'package:soon_sak/domain/model/content/exposure_content.dart';
export 'package:soon_sak/domain/model/content/youtube_content.dart';
export 'package:soon_sak/domain/model/content/content_main_info.dart';
export 'package:soon_sak/domain/model/content/category_based_content_list.dart';
export 'package:soon_sak/domain/enum/content_season_type_enum.dart';
export 'package:soon_sak/domain/enum/ott_type_enum.dart';
export 'package:soon_sak/domain/model/content/SplittedIdAndType.dart';
export 'package:soon_sak/domain/model/content/content_detail_info.dart';
export 'package:soon_sak/domain/model/content/searched_content.dart';
export 'package:soon_sak/domain/service/content_service.dart';
export 'package:soon_sak/domain/useCase/tmdb/load_content_credit_info_use_case.dart';
export 'package:soon_sak/domain/useCase/tmdb/load_content_img_list_use_case.dart';
export 'package:soon_sak/domain/model/content/content_argument_format.dart';
export 'package:soon_sak/domain/model/youtube/youtube_channel_info.dart';
export 'package:soon_sak/domain/base/base_single_data_model.dart';

// Presentation
export 'package:soon_sak/presentation/screens/qurationHistory/localWidget/contents_grid_view.dart';
export 'package:soon_sak/presentation/screens/quration/register/pageView/register_video_link_page_view.dart';
export 'package:soon_sak/presentation/screens/quration/register/pageView/search_content_page_view.dart';
export 'package:soon_sak/presentation/screens/quration/register/register_view_model.dart';
export 'package:soon_sak/presentation/common/dialog/app_dialog.dart';
export 'package:soon_sak/presentation/common/textField/search_bar.dart';
export 'package:soon_sak/presentation/common/animated_index_stack.dart';
export 'package:soon_sak/presentation/screens/home/home_screen.dart';
export 'package:soon_sak/presentation/common/sticky_delegate_container.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_scaffold_controller.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_scaffold.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/content_detail_info_tab_view.dart';
export 'package:soon_sak/presentation/common/video_thumbnail_img_with_player_btn.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_view_model.dart';
export 'package:soon_sak/presentation/common/round_profile_img.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/section_title.dart';
export 'package:soon_sak/presentation/base/base_screen.dart';
export 'package:soon_sak/presentation/base/base_view.dart';
export 'package:soon_sak/presentation/screens/tabs/tabs_view_model.dart';
export 'package:soon_sak/presentation/screens/tabs/tabs_binding.dart';
export 'package:soon_sak/presentation/screens/tabs/tabs_screen.dart';
export 'package:soon_sak/presentation/common/content_post_item.dart';
export 'package:soon_sak/presentation/common/content_post_slider.dart';
export 'package:soon_sak/presentation/common/icon_ink_well_button.dart';
export 'package:soon_sak/presentation/screens/home/localWidget/home_scaffold.dart';
export 'package:soon_sak/presentation/screens/home/home_view_model.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_binding.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_screen.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/main_content_tab_view.dart';
export 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold_controller.dart';
export 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold.dart';
export 'package:soon_sak/presentation/screens/search/search_view_model.dart';
export 'package:soon_sak/presentation/screens/search/localWidget/searched_result_paged_list_view.dart';
export 'package:soon_sak/presentation/common/skeleton_box.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/content_video_views_by_case.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/single_video_skeleton_view.dart';
export 'package:soon_sak/presentation/screens/qurationHistory/localWidget/quration_history_scaffold.dart';
export 'package:soon_sak/presentation/screens/qurationHistory/quration_history_view_model.dart';
export 'package:soon_sak/presentation/screens/qurationHistory/tabview/completed_contents_tab_view.dart';
export 'package:soon_sak/presentation/screens/qurationHistory/tabview/in_progress_contents_tab_view.dart';
export 'package:soon_sak/presentation/screens/qurationHistory/tabview/pending_contents_tab_view.dart';

// Utilities
export 'package:soon_sak/utilities/constants/invalid_search_character.dart';
export 'package:soon_sak/utilities/extensions/determine_content_type.dart';
export 'package:soon_sak/utilities/extensions/get_last_character_of_string.extension.dart';
export 'package:soon_sak/utilities/constants/bottom_navigation_constants.dart';
export 'package:soon_sak/data/mixin/api_error_handler_mixin.dart';
export 'package:soon_sak/utilities/result.dart';
export 'package:soon_sak/utilities/youtube_meta_data.dart';
export 'package:soon_sak/app/config/app_insets.dart';
export 'package:flutter_styled_toast/flutter_styled_toast.dart';
export 'package:soon_sak/utilities/extensions/check_null_state_extension.dart';
export 'package:soon_sak/utilities/extensions/tmdb_img_path_extension.dart';
export 'package:soon_sak/utilities/formatter.dart';
export 'package:soon_sak/presentation/common/alert_widget.dart';
