# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

|Column                 |Type        |Options            |
|-----------------------|------------|-------------------|
|nickname               |string      |null: false        |
|email                  |string      |null: false        | 
|password               |string      |null: false        | 
|first_name             |string      |null: false        |
|family_name            |string      |null: false        |
|first_name_kana        |string      |null: false        |
|family_name_kana       |string      |null: false        | 
|birth_date             |date        |null: false        | 

### Association
- has_many :items
- has_many :item_purchases


## items テーブル

|Column                       |Type        |Option                        |                             
|-----------------------------|------------|------------------------------|
|name                         |string      |null:false                    |
|info                         |text        |null:false                    |
|category_select_id           |integer     |null:false, foreign_key:true  |
|sales_status_select_id       |integer     |null:false, foreign_key:true  |
|shipping_fee_status_select_id|integer     |null:false, foreign_key:true  |
|prefecture_select_id         |integer     |null:false, foreign_key:true  |
|schduled_delivery_select_id  |integer     |null:false, foreign_key:true  |
|price                        |integer     |null:false                    |
|user_id                      |references  |null:false, foreign_key:true  |                    |

### Association
- belongs_to :user
- has_many :item_purchases


##  item_purchases テーブル

| Column        |Type           |Options                         |
|               |               |                                |
|user_id        |references     |null:false, foreign_key:true    |
|item_id        |references     |null:false, foreign_key:true    |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


##  address テーブル

|Column                 |type        |Option           |
|-----------------------|------------|-----------------|
|post_code              |integer(7)  |null:false       |
|prefecture_select_id   |integer     |null:false       |
|city                   |string      |null:false       |
|municipality           |string      |null:false       |
|building_name          |string      |-                |
|phone_number           |string      |null:false       |
|buyer_id               |references  |foreign_key:true |

### Association
- belongs_to :item_purchases


