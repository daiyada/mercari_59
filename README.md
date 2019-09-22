# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|mailadress|string|null: false|
|password|string|null: false|
|cellphone_number|string|null: false|
|name_family|string|null: false|
|name_family_kana|string|null: false|
|name_first|string|null: false|
|name_first_kana|string|null: false|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|adress|string|null: false|
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
|user_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: true|
|p_name|string|presence: true|
|p_descript|string|presence: true|
|condition|string|presence: true|
|delivery_condition|string|presence: true|
|delivery_from|string|presence: true|
|due_time_d|string|presence: true|
|p_price|string|presence: true|
|sall_condition|integer|presence: true|

### Association
- has_many :images
- belongs_to :user
- has_many :images
- belongs_to :big-categories

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false,foreign_key: true|
|image|integer|

### Association
- belongs_to :product

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false,foreign_key: true|
|p_address|integer|presence: true|

### Association
- belongs_to :product

