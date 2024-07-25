import 'package:get/get.dart';

import '../views/exam_views/create/create_exam_2_screen.dart';
import '../views/exam_views/create/create_exam_screen.dart';
// import '../views/exam/loading_screen.dart';
import '../views/exam_views/create/create_exam_yourself_screen.dart';
import '../views/exam_views/edit_exam_screen.dart';
import '../views/exam_views/export/export_exam_success.dart';
import '../views/exam_views/input_info_exam_screen.dart';
import '../views/exam_views/loading/loading_screen.dart';
import '../views/exam_views/search/search_result_view.dart';
import '../views/exam_views/search/search_view_screen.dart';
import '../views/exam_views/thi_thu/result_detail_screen.dart';
import '../views/exam_views/view_exam_screen.dart';
import '../views/login_views/password/accuracy_otp_screen.dart';
import '../views/login_views/password/change_password_screen.dart';
import '../views/login_views/password/forgot_password_screen.dart';
import '../views/login_views/login/login2_screen.dart';
import '../views/login_views/password/new_password_screen.dart';
import '../views/login_views/register/register_2_screen.dart';
import '../views/login_views/register/register_screen.dart';
import '../views/login_views/login/login_screen.dart';
import '../views/login_views/splash/splash_screen.dart';
import '../views/main_views/main_tabs/home_tabs/channel_list_tab/channel_screen.dart';
import '../views/main_views/main_tabs/menu/bxh_views/bxh_screen.dart';
import '../views/exam_views/detail/exam_detail_screen.dart';
import '../views/exam_views/thi_thu/thi_thu_screen.dart';
import '../views/main_views/mascot/mascot_screen.dart';
import '../views/main_views/main_tabs/menu/nhiem_vu_views/nhiem_vu_screen.dart';
import '../views/exam_views/on_thi_screen.dart';
import '../views/exam_views/thi_thu/success_exam_screen.dart';
import '../views/main_views/main_tabs/menu/thanh_tich_views/thanh_tich_screen.dart';
import '../views/exam_views/thi_thu/xac_nhan_nop_screen.dart';
import '../views/main_views/main_tabs/menu/info_views/info/edit_info_screen.dart';
import '../views/exam_views/result/exam_result_screen.dart';
import '../views/main_views/main_tabs/menu/info_views/introduce/gioi_thieu_screen.dart';
import '../views/main_views/main_tabs/menu/info_views/info/info_screen.dart';
import '../views/main_views/main_tabs/menu/info_views/g_point/lich_su_g_sceen.dart';
import '../views/main_views/main_wrapper/main_wrapper.dart';
import '../views/main_views/main_tabs/menu/info_views/g_point/nap_g_2_screen.dart';
import '../views/main_views/main_tabs/menu/info_views/g_point/nap_g_screen.dart';
import '../views/exam_views/result/result_screen.dart';
import '../views/main_views/main_tabs/menu/info_views/info/tai_khoan_ca_nhan_screen.dart';

class Routes {
  static const splashScreen = '/';
  static const home = '/home';
  static const register = '/register';
  static const register2 = '/register2';
  static const signup = '/signup';
  static const login2 = '/login2';
  static const forgotPassword = '/forgot_password';
  static const accuracyOTP = '/accuracyOTP';
  static const newPassword = '/newPassword';
  static const examResult = '/examResult';
  static const result = '/result';
  static const create = '/create';
  static const viewExam = '/view-exam';
  static const loading = '/loading';
  static const inputInfoExam = '/input-info-exam';
  static const exportExamSusscess = '/export-exam-susscess';
  static const searchView = '/search-view';
  static const resultSearch = '/result-search';
  static const createExamYourselt = '/create-exam-yourself';
  static const examDetail = '/exam-detail';
  static const onThi = '/on-thi';
  static const successExam = '/success-exam';
  static const thiThu = '/thi-thu';
  static const xacNhanNop = '/xac-nhan-nop';
  static const linhVatDetail = '/linh-vat-detail';
  static const nhiemVu = '/nhiem-vu';
  static const thanhTich = '/thanh-tich';
  static const bxh = '/bxh';
  static const info = '/info';
  static const taiKhoanCaNhan = '/tai-khoan-ca-nhan';
  static const editInfo = '/edit-info';
  static const napG = '/nap-g';
  static const napG2 = '/nap-g-2';
  static const lichSuG = '/lich-su-g';
  static const gioiThieu = '/gioi-thieu';
  static const loadingScreen = '/loading';
  static const channelScreen = '/channel-screen';
  static const resultDetail = '/result-detail';
  static const changePassword = '/change-password';
  static const createExam2 = '/create-exam-2';
  static const editExam = '/edit-exam';

  static final routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: home, page: () => MainWrapper()),
    GetPage(name: inputInfoExam, page: () => InputInfoExamScreen()),
    GetPage(name: create, page: () => CreateExamScreen()),
    GetPage(name: loadingScreen, page: () => const LoadingScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: register2, page: () => Resgiter2Screen()),
    GetPage(name: signup, page: () => LoginScreen()),
    GetPage(name: login2, page: () => Login2Screen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: accuracyOTP, page: () => AccuracyOTPScreen()),
    GetPage(name: newPassword, page: () => NewPasswordScreen()),
    GetPage(name: examResult, page: () => ExamResultScreen()),
    GetPage(name: result, page: () => ResultScreen()),
    GetPage(name: viewExam, page: () => ViewExamScreen()),
    GetPage(name: exportExamSusscess, page: () => ExportExamSusscess()),
    GetPage(name: searchView, page: () => SearchViewScreen()),
    GetPage(name: resultSearch, page: () => SearchResultView()),
    GetPage(
      name: createExamYourselt,
      page: () => const CreateExamYourselrScreen(),
    ),
    GetPage(name: examDetail, page: () => ExamDetailScreen()),
    GetPage(name: createExam2, page: () => CreateExam2Screen()),
    GetPage(name: onThi, page: () => OnThiScreen()),
    GetPage(name: successExam, page: () => SuccessExamScreen()),
    GetPage(name: thiThu, page: () => ThiThuScreen()),
    GetPage(name: xacNhanNop, page: () => XacNhanNopScreen()),
    GetPage(name: linhVatDetail, page: () => MascotScreen()),
    GetPage(name: nhiemVu, page: () => const NhiemVuScreen()),
    GetPage(name: thanhTich, page: () => const ThanhTichScreen()),
    GetPage(name: bxh, page: () => BXHScreen()),
    GetPage(name: info, page: () => InfoScreen()),
    GetPage(name: taiKhoanCaNhan, page: () => TaiKhoanCaNhanScreen()),
    GetPage(name: editInfo, page: () => EditInfoScreen()),
    GetPage(name: napG, page: () => NapGScreen()),
    GetPage(name: napG2, page: () => const NapG2Screen()),
    GetPage(name: lichSuG, page: () => const LichSuGSceen()),
    GetPage(name: gioiThieu, page: () => const GioiThieuScreen()),
    GetPage(name: channelScreen, page: () => ChannelScreen()),
    GetPage(name: resultDetail, page: () => ResultDetailScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: editExam, page: () => EditExamScreen()),
  ];
}
