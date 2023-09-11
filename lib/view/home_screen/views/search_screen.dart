import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/recent_search_network/recent_search_network.dart';

class SearchScreen extends GetView<SearchViewController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(
        centerTitle: false,
        leading: GetInkwell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: height_22,
          ),
        ),
        titleWidget: searchTextFieldWidget(
          controller: controller.searchController,
          focusNode: controller.searchNode,
          hint: TextFile.searchFoodRestaurant.tr,
          onChanged: (value) {
            controller.searchedValue.value = value;
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Stack(
            children: [
              controller.searchController?.text == null ||
                      controller.searchController?.text == ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _recentSearchesAndClearAll(),
                        _recentSearchesList(),
                        _categoriesText(),
                        _categoryGridView(),
                      ],
                    ).marginAll(margin_15)
                  : Container(),
              _buildAutocomplete(value: controller.searchedValue.value),
            ],
          ),
        ),
      ),
    );
  }

  _recentSearchesAndClearAll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(TextFile.recentSearches.tr,
            style: AppStyle.txtDMSansBold16Black90001
                .copyWith(color: Colors.black)),
        GetInkwell(
          onTap: () {
          controller.clearList();
          },
          child: Text(
            TextFile.clearAll.tr,
            textAlign: TextAlign.center,
            style: AppStyle.txtDMSansRegular12GreenA700,
          ),
        )
      ],
    );
  }

  _recentSearchesList() {
    return controller.recentSearchesList.isEmpty
        ? Center(
            child: Text(
              'No Recent Searches',
              style: AppStyle.txtDMSansRegular12Black900,
            ).marginSymmetric(vertical: margin_20),
          )
        : Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: controller.recentSearchesList.reversed.map((element) {
              return GetInkwell(
                  onTap: () {
                    controller.searchController?.clear();
                    controller.searchNode?.requestFocus();
                    controller.searchController?.text = element.title ?? '';
                    controller.searchedValue.value = element.title ?? '';
                  },
                  child: Container(
                      padding: EdgeInsets.all(margin_8),
                      margin: EdgeInsets.all(margin_4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorConstant.greenA700),
                          borderRadius:
                              BorderRadius.all(Radius.circular(radius_25))),
                      child: SizedBox(
                          child: Text(
                        element.title ?? '',
                        textAlign: TextAlign.center,
                      ))));
            }).toList(),
          ).marginSymmetric(vertical: margin_10);
  }

  _categoriesText() {
    return Text(
      TextFile.categories.tr,
      style: AppStyle.txtDMSansBold16Black90001,
    );
  }

  _categoryGridView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.categoriesList.length,
      padding: EdgeInsets.symmetric(vertical: margin_15),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: height_10,
          childAspectRatio: 0.72,
          mainAxisSpacing: height_10,
          crossAxisCount: 4),
      itemBuilder: (context, index) {
        return GetInkwell(
          onTap: () {
            Get.toNamed(AppRoutes.itemListScreen, arguments: {
              keyCategory: controller.categoriesList[index].categoryName,
              keyId: controller.categoriesList[index].categoryId
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AssetImageWidget(
                  height: height_200,
                  width: width_200,
                  controller.categoriesList[index].imageUrl,
                  boxFit: BoxFit.cover,
                  radiusAll: radius_100,
                ),
              ),
              Text(
                controller.categoriesList[index].categoryName ?? '',
                maxLines: 2,
                textAlign: TextAlign.center,
              ).marginOnly(top: margin_10)
            ],
          ),
        );
      },
    );
  }

  Widget _buildAutocomplete({String? value}) {
    return value == null || value == ''
        ? Container()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: margin_15),
            decoration: BoxDecoration(color: ColorConstant.gray50),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      index == 0
                          ? '${TextFile.search.tr} $value ${TextFile.inFood.tr}'
                          : '${TextFile.search.tr} $value ${TextFile.inRestaurant.tr}',
                      maxLines: 2),
                  onTap: () {

                    controller.addItemToRecentSearches(
                        value: value, index: index);
                  },
                );
              },
            ),
          );
  }
}
