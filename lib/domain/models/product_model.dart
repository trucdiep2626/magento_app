import 'package:magento_app/domain/models/custom_attributes_model.dart';

class ProductModel {
  int? id;
  String? sku;
  String? name;
  int? attributeSetId;
  int? price;
  int? status;
  int? visibility;
  String? typeId;
  String? createdAt;
  String? updatedAt;
  ExtensionAttributes? extensionAttributes;
  List<ProductLinks>? productLinks;
  // List<Null>? options;
  List<MediaGalleryEntries>? mediaGalleryEntries;
//  List<Null>? tierPrices;
  List<CustomAttributes>? customAttributes;

  ProductModel(
      {this.id,
      this.sku,
      this.name,
      this.attributeSetId,
      this.price,
      this.status,
      this.visibility,
      this.typeId,
      this.createdAt,
      this.updatedAt,
      this.extensionAttributes,
      this.productLinks,
      //   this.options,
      this.mediaGalleryEntries,
      //   this.tierPrices,
      this.customAttributes});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    price = json['price'];
    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['product_links'] != null) {
      productLinks = <ProductLinks>[];
      json['product_links'].forEach((v) {
        productLinks!.add(ProductLinks.fromJson(v));
      });
    }
    // if (json['options'] != null) {
    //   options = new List<Null>();
    //   json['options'].forEach((v) {
    //     options.add(new Null.fromJson(v));
    //   });
    // }
    if (json['media_gallery_entries'] != null) {
      mediaGalleryEntries = <MediaGalleryEntries>[];
      json['media_gallery_entries'].forEach((v) {
        mediaGalleryEntries!.add(MediaGalleryEntries.fromJson(v));
      });
    }
    // if (json['tier_prices'] != null) {
    //   tierPrices = new List<Null>();
    //   json['tier_prices'].forEach((v) {
    //     tierPrices.add(new Null.fromJson(v));
    //   });
    // }
    if (json['custom_attributes'] != null) {
      customAttributes = <CustomAttributes>[];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['name'] = name;
    data['attribute_set_id'] = attributeSetId;
    data['price'] = price;
    data['status'] = status;
    data['visibility'] = visibility;
    data['type_id'] = typeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    if (productLinks != null) {
      data['product_links'] = productLinks!.map((v) => v.toJson()).toList();
    }
    // if (this.options != null) {
    //   data['options'] = this.options!.map((v) => v.toJson()).toList();
    // }
    if (mediaGalleryEntries != null) {
      data['media_gallery_entries'] =
          mediaGalleryEntries!.map((v) => v.toJson()).toList();
    }
    // if (this.tierPrices != null) {
    //   data['tier_prices'] = this.tierPrices.map((v) => v.toJson()).toList();
    // }
    if (customAttributes != null) {
      data['custom_attributes'] =
          customAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<int>? websiteIds;
  List<CategoryLinks>? categoryLinks;

  ExtensionAttributes({this.websiteIds, this.categoryLinks});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    websiteIds = json['website_ids'].cast<int>();
    if (json['category_links'] != null) {
      categoryLinks = <CategoryLinks>[];
      json['category_links'].forEach((v) {
        categoryLinks!.add(CategoryLinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['website_ids'] = websiteIds;
    if (categoryLinks != null) {
      data['category_links'] = categoryLinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryLinks {
  int? position;
  String? categoryId;

  CategoryLinks({this.position, this.categoryId});

  CategoryLinks.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    data['category_id'] = categoryId;
    return data;
  }
}

class ProductLinks {
  String? sku;
  String? linkType;
  String? linkedProductSku;
  String? linkedProductType;
  int? position;

  ProductLinks(
      {this.sku,
      this.linkType,
      this.linkedProductSku,
      this.linkedProductType,
      this.position});

  ProductLinks.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    linkType = json['link_type'];
    linkedProductSku = json['linked_product_sku'];
    linkedProductType = json['linked_product_type'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['link_type'] = linkType;
    data['linked_product_sku'] = linkedProductSku;
    data['linked_product_type'] = linkedProductType;
    data['position'] = position;
    return data;
  }
}

class MediaGalleryEntries {
  int? id;
  String? mediaType;
  String? label;
  int? position;
  bool? disabled;
  List<String>? types;
  String? file;

  MediaGalleryEntries(
      {this.id,
      this.mediaType,
      this.label,
      this.position,
      this.disabled,
      this.types,
      this.file});

  MediaGalleryEntries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    types = json['types'].cast<String>();
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['label'] = label;
    data['position'] = position;
    data['disabled'] = disabled;
    data['types'] = types;
    data['file'] = file;
    return data;
  }
}
