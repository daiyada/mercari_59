# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|mailaddress|string|null: false|
|password|string|null: false|
|cellphone_number|string|null: false|
|name_family|string|null: false|
|name_family_kana|string|null: false|
|name_first|string|null: false|
|name_first_kana|string|null: false|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|phone_number|string||
|card_naumber|string|null: false|
|card_expiration_date_month|string|null: false|
|card_expiration_date_year|string|null: false|
|card_security_code|string|null: false|

### Association
- has_many :products


## productsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|p_name|string|null: false, index: true|
|p_descript|text|null: false|
|condition|string|null: false|
|delivery_condition|string|null: false|
|delivery_from|string|null: false|
|due_time_d|string|null: false|
|p_price|string|null: false|
|stock|integer|null: false|
|brand|string|null: false|
|size|string|null: false|
|big_categories|string|null: false|
|mid_categories|string|null: false|
|small_categories|string|null: false|

### Association
- has_many :images
- belongs_to :user
- belongs_to :big-category
- belongs_to :mid-category
- belongs_to :small-category

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to :product


## big_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :products
- has_many :mid_categories


## mid_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|big_category|references|null: false, foreign_key: true|

### Association
- has_many :products
- has_many :small_categories
- belongs_to :big-category


## small_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|mid_category|references|null: false, foreign_key: true|

### Association
- has_many :products
- belongs_to :mid_category
