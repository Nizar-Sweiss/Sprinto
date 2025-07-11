library project_details;

import 'dart:convert';

import 'package:app/config/theme.dart';
import 'package:app/utils/custom_app_bar.dart';
import 'package:app/utils/custom_button.dart';
import 'package:app/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../config/colors.dart';
import '../../services/api_service.dart';
import '../../services/http_service.dart';
import '../../services/request_handler.dart';
import '../home/index.dart';
import '../home/models/projects.dart';
import 'models/task.dart';

part 'controllers/project_details_controller.dart';
part 'views/project_details_screen.dart';
part 'widgets/task_card.dart';