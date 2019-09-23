# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|mailaddress|string|null: false, unique: true|
|password|string|null: false|
|cellphone_number|string|null: false, unique: true|
|name_family|string|null: false|
|name_family_kana|string|null: false|
|name_first|string|null: false|
|name_first_kana|string|null: false|

### Association
- has_many :products
- has_one :card
- has_one :address


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string||
|phone_number|string||

### Association
- belongs_to :user


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|string|null: false, unique: true|
|card_expiration_date_month|string|null: false|
|card_expiration_date_year|string|null: false|
|card_security_code|string|null: false|

### Association
- belongs_to :user


## productsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|name|string|null: false, index: true|
|descript|text|null: false|
|condition|string|null: false|
|price|string|null: false|
|stock_status|integer|null: false|
|brand|string||
|size|string|null: false|
|category|references|null: false, foreign_key: true|

### Association
- has_many :images
- has_one :delivery
- belongs_to :user
- belongs_to :category


## deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|pay_for_shipping|string|null: false|
|delivery_from|string|null: false|
|due_time_day|string|null: false|

### Association
- belongs_to :product


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to :product


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|path|string|index: true|
|name|string|null: false|

### Association
- has_many :products
- has_ancestory