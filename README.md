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