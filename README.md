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
|birthday               |date        |null: false        | 

### Association
- has_many :items
- has_many :item_purchases


## items テーブル

|Column                       |Type        |Option            |                             
|-----------------------------|------------|------------------|
|name                         |string      |null:false        |
|info                         |text        |null:false        |
|category_id                  |integer     |null:false        |
|status_id                    |integer     |null:false        |
|postage_id                   |integer     |null:false,       |
|prefecture_id                |integer     |null:false        |
|schduled_delivery_id         |integer     |null:false        |
|price                        |integer     |null:false        |
|user                         |references  |null:false        |

### Association
- belongs_to :user
- has_many :item_purchases


##  orders テーブル

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
|post_code              |string      |null:false       |
|prefecture_id          |integer     |null:false       |
|city                   |string      |null:false       |
|municipality           |string      |null:false       |
|building_name          |string      |-                |
|phone_number           |string      |null:false       |
|order                  |references  |foreign_key:true |

### Association
- belongs_to :item_purchases


