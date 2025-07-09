  library home;

import 'dart:convert';

import 'package:app/config/colors.dart';
import 'package:app/utils/custom_app_bar.dart';
import 'package:app/utils/custom_search_bar.dart';
import 'package:app/utils/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/app_routes.dart';
import '../../services/api_service.dart';
import '../../services/http_service.dart';
import '../../services/request_handler.dart';
import 'models/projects.dart';
part 'views/home_screen.dart';
part 'controllers/home_controller.dart';
part 'widgets/project_card.dart';