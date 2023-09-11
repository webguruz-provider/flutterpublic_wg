class NutritionModel {
  var id;
  var itemId;
  var nutritionId;
  var nutritionText;
  var maxValue;
  var value;
  var languageId;
  var createdOn;

  NutritionModel(
      {this.id,
        this.itemId,
        this.nutritionId,
        this.nutritionText,
        this.maxValue,
        this.value,
        this.languageId,
        this.createdOn});

  NutritionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    nutritionId = json['nutrition_id'];
    nutritionText = json['nutrition_text'];
    maxValue = json['max_value'];
    value = json['value'];
    languageId = json['language_id'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['nutrition_id'] = this.nutritionId;
    data['nutrition_text'] = this.nutritionText;
    data['max_value'] = this.maxValue;
    data['value'] = this.value;
    data['language_id'] = this.languageId;
    data['created_on'] = this.createdOn;
    return data;
  }
}
