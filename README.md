# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|cellphone_number|string|null: false, unique: true|
|name_family|string|null: false|
|name_family_kana|string|null: false|
|name_first|string|null: false|
|name_first_kana|string|null: false|

### Association
- has_many :bought_items
- has_many :saling_items
- has_many :sold_items
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
|number|string|null: false, unique: true|
|expiration_date_month|string|null: false|
|expiration_date_year|string|null: false|
|security_code|string|null: false|

### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|descript|text|null: false|
|condition|string|null: false|
|price|integer|null: false|
|stock_status|integer|null: false|
|brand|string||
|size|string|null: false|
|category|references|null: false, foreign_key: true|
|saler_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|

### Association
- has_many :images
- has_one :delivery
- belongs_to :saler, class_name: "User"
- belongs_to :buyer, class_name: "User"
- belongs_to :category


## deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|pay_for_shipping|string|null: false|
|delivery_from|string|null: false|
|due_time_day|string|null: false|

### Association
- belongs_to :item


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|image|string|null: false|

### Association
- belongs_to :item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|ancestry|string|index: true|
|name|string|null: false|

### Association
- has_many :items
- has_ancestry