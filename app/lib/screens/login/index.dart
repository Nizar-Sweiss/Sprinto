library login;

import 'dart:convert';

import 'package:app/config/app_config.dart';
import 'package:app/config/colors.dart';
import 'package:app/utils/custom_button.dart';
import 'package:app/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';
import '../../routes/app_routes.dart';
import '../../services/api_service.dart';
import '../../services/http_service.dart';
import '../../services/request_handler.dart';
import '../../utils/storage/storage.dart';
import 'controllers/animation_controller.dart';
part 'views/login_screen.dart';
part 'controllers/login_controller.dart';