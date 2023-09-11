import 'package:foodguru/app_values/export.dart';

class DineInSelectRestaurantScreen
    extends GetView<DineInSelectRestaurantController> {
  const DineInSelectRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
