import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/extensions/extensions.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
import '../../../address/data/response/address_response.dart';
import '../../../product/data/response/product_response.dart';
import '../../data/response/coupon_response.dart';

part 'cart_state.dart';

class CartCubit extends MCubit<CartInitial> {
  CartCubit() : super(CartInitial.initial());

  @override
  String get nameCache => 'cart';


  //region getData

  Future<void> getDataFromCache() async => await getFromCache(
        fromJson: Product.fromJson,
        state: state,
        onSuccess: (data) {
          emit(state.copyWith(result: data));
        },
      );

  //endregion

  //region CRUD

  Future<bool> _addToCart(Product item) async {
    await getDataFromCache();
    final products = state.result;
    final index = products.indexWhere((p) => p.id == item.id);

    if (index != -1) {
      final updated = products[index];
      final newCount = updated.count + item.count;

      if (newCount <= updated.quantity) {
        updated.count = newCount;
        await addOrUpdateProductToCache(updated);
        return true;
      } else {
        loggerObject.w("لا يمكن إضافة أكثر من الكمية المتوفرة: ${updated.quantity}");
        return false;
      }
    } else {
      if (item.count <= item.quantity) {
        await addOrUpdateProductToCache(item);
        return true;
      } else {
        loggerObject.w("لا يمكن إضافة أكثر من الكمية المتوفرة: ${item.quantity}");
        return false;
      }
    }
  }

  Future<void> addToCart(Product item) async {
    var r = await _addToCart(item);

    if (r) {
      NoteMessage.showSuccessSnackBar(message: S.of(ctx!).done, context: ctx!);
    } else {
      NoteMessage.showErrorSnackBar(message: "لا يمكن إضافة أكثر من الكمية المتوفرة: ${item.quantity}", context: ctx!);
    }
  }

  Future<void> decrementQuantity(Product item) async {
    await getDataFromCache();
    final products = state.result;
    final index = products.indexWhere((p) => p.id == item.id);
    if (index != -1) {
      final updated = products[index];
      if (updated.count > 1) {
        updated.count -= 1;
        await addOrUpdateProductToCache(updated);
      } else {
        await deleteProductFromCache([updated.id.toString()]);
      }
    }
  }

  Future<bool> incrementQuantity(Product item) async {
    await getDataFromCache();
    final products = state.result;
    final index = products.indexWhere((p) => p.id == item.id);

    if (index != -1) {
      final updated = products[index];

      if (updated.count < updated.quantity) {
        updated.count += 1;
        await addOrUpdateProductToCache(updated);
        return true;
      } else {
        loggerObject.w("لا يمكن زيادة الكمية، الحد الأقصى هو ${updated.quantity}");
        return false;
      }
    } else {
      if (item.count <= item.quantity) {
        await addToCart(item);
        return true;
      } else {
        loggerObject.w("لا يمكن إضافة أكثر من الكمية المتاحة: ${item.quantity}");
        return false;
      }
    }
  }

  Future<void> removeFromCart(Product item) async {
    await deleteProductFromCache([item.id.toString()]);
  }

  //endregion

  void setCouponCode(String coupon) {
    emit(state.copyWith(request: coupon));
  }

  void setCoupon(CouponData coupon) {
    emit(state.copyWith(coupon: coupon));
  }

  void setAddress(Address address) {
    emit(state.copyWith(address: address));
  }

  @override
  Future<void> clearCash() async {
    await deleteProductFromCache(state.result.map((e) => e.id.toString()).toList());
  }

  Future<void> addOrUpdateProductToCache(Product item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Product.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteProductFromCache(List<String> ids) async {
    final listJson = await deleteDate(ids);
    if (listJson == null) return;
    final list = listJson.map((e) => Product.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
