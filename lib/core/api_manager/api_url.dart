import '../strings/enum_manager.dart';

class GetUrl {
  static const address = 'address';
  static const order = 'order';
  static const governorate = 'governorate';

  static const favorite = 'favorite';
  static const product = 'product';
  static const ads = 'ads';
  static const category = 'category';
  static const exam = 'exam';

  static const temp = '';
  static const getHome = 'home';

  static var chapters = 'chapter/by-course';

  static var banner = '';
  static var banners = 'advertisement';

  static var group = '';

  static var groups = 'group';

  static var temps = '';

  //--------------

  static const getAllLessons = 'lessons';

  static const getAllLessonsFree = 'lessons/free';

  static const getAllSeasons = 'seasons';

  static const getCourseProgress = 'courses/progress-user';

  static const getMe = 'auth/me';

  static const getAllNotifications = 'notification';

  static const getSocialMedia = 'social-media';

  static const privacyPolicy = 'privacy-policy';

  static const getAnnouncements = 'announcements';

  static const productById = 'products';
  static const products = 'products';
  static const search = 'search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static const setting = 'settings';

  static const orders = 'orders';

  static const categoryById = 'category';
  static const subCategoryById = 'subCategory';

  static const coupon = 'coupon/check';

  static const flashDeals = 'products/flash-deals';

  static const categories = 'categories';
  static const slider = 'ads/sliders';

  static const colors = 'colors';

  static const manufacturers = 'manufacturers';

  static const newArrivalProducts = 'products/new-arrivals';
  static const adss = 'ads';

  static const cart = 'carts';

  static const profile = 'profile';

  static const orderById = 'orders';

  static const subCategories = 'categories/sub';

  static const governors = 'governorate';

  static const orderStatus = 'orders/statues';

  static const driverLocation = 'orders/coordinate';

  static const getMessages = 'drivers/messages';

  static const getSupportMessages = 'conversations';

  static const getRoomMessages = 'messages';

  static const faq = 'questions';

  static const termsAndConditions = 'pages';

  static const educationalGrade = 'educational-grade';
  static const educationalGradeSection = 'educational-grade/sections';

  static const teachersFilter = 'teacher/filter-teacher';

  static const teacher = 'teacher';

  static const exams = 'exam';
  static const freeExams = 'exam/free-exams';

  static var examCategorized = 'exam/categorized';
}

class PostUrl {
  static const addresses = 'address';
  static const createAddress = 'address';
  static const orders = 'order';
  static const governorates = 'governorate';

  static const createOrder = 'order';
  static const createGovernorate = 'governorate';

  static const favorites = 'favorite';
  static const createFavorite = 'favorite';

  // static const products = 'product/last-product';
  static String products(int type) {
    switch (GetProductsType.values[type]) {
      case GetProductsType.non:
        return 'product';
      case GetProductsType.topSell:
        return 'product/top-selling-products';
      case GetProductsType.latest:
        return 'product/last-product';
      case GetProductsType.offers:
        return 'product/product-with-offer';
    }
  }

  static const createAds = 'ads';
  static const createProduct = 'Product/Add';

  static const categories = 'category';
  static const createCategory = 'category';
  static const createExam = 'exam';
  static const addReview = 'reviews';
  static const loginUrl = 'auth/login';
  static const signup = 'auth/register';

  static const forgetPassword = 'auth/forget-password';

  static const resetPassword = 'auth/reset-password';

  static const closeVideo = 'lesson/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';
  static const uploadFile = 'add-images';

  static const insertCode = 'courses/insert-code';
  static const logout = 'logout';

  static const confirmCode = 'auth/otp-check';
  static const otpPassword = 'auth/reset-password';

  static const toggleFav = 'favorite/toggle';

  static const restPass = 'reset-password';

  static const createEPaymentOrder = 'checkout/credit';

  static const resendCode = 'auth/otp-resend';

  static const addToCart = 'carts';

  static const updateProfile = 'profile';

  static const addSupportMessage = 'messages/add';

  static const loginSocial = 'social/login';
  static const addPhone = 'social/add-phone';

  static const socialVerifyPhone = 'social/verify-phone';

  static var changePassword = 'auth/change-password';
  static var payCourse = 'course/active';
  static var paySummary = 'summary/active';
  static var payExam = 'exam/active';

  static var createTemp = '';

  static var temps = '';

  static var createGroup = '';

  static String addMessage(int id) {
    return 'drivers/messages/$id/add';
  }

  static String increase(int id) {
    return 'carts/products/$id/quantity/increase';
  }

  static String decrease(int id) {
    return 'carts/products/$id/quantity/decrease';
  }
}

class PutUrl {
  static const updateAddress = 'address';
  static const updateOrder = 'order';
  static const updateGovernorate = 'governorate';

  static const updateFavorite = 'favorite';
  static const updateProduct = 'Product/Update';
  static const updateAds = 'ads';
  static const updateCategory = 'category';
  static const updateExam = 'NON/Update';
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';

  static const follow = 'teacher/follow';
  static const like = 'lesson/like';
  static const desLike = 'lesson/unlike';

  static const startExam = 'exam/start-exam';
  static var updateTemp = '';

  static var updateGroup = '';
}

class DeleteUrl {
  static const deleteAddress = 'address';
  static const deleteOrder = 'order';
  static const deleteGovernorate = 'governorate';

  static const deleteFavorite = 'favorite';
  static const deleteProduct = 'Product/Delete';
  static const deleteAds = 'ads';
  static const deleteCategory = 'category';
  static const deleteExam = 'NON/Delete';
  static const removeFavorite = 'favorites';

  static const removeFromCart = 'carts/products';

  static const clearCart = 'carts';

  static const deleteMyAccount = 'auth/delete-account';

  static var deleteTemp = '';

  static var deleteGroup = '';
}

const additionalConst = '/api/v1/';

String get baseUrl {
  return live;
  // return test;
}

//https://back.victoriairaq.com
const live = 'back.victoriairaq.com';
const test = 'back.victoriairaq.com';
