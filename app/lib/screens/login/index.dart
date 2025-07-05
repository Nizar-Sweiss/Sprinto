library login;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../routes/app_routes.dart';
import '../../services/api_service.dart';
import '../../services/http_service.dart';
import '../../services/request_handler.dart';
part 'views/login_screen.dart';
part 'controllers/login_controller.dart';