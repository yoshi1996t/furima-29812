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
|password_confirmation  |string      |null: false        | 
|first_name             |string      |null: false        |
|family_name            |string      |null: false        |
|first_name_kana        |string      |null: false        |
|family_name_kana       |string      |null: false        | 
|birth_day              |date        |null: false        | 
|member_registration    |string      |null: false        |



## items テーブル

|Column                       |Type        |Option                        |                             
|-----------------------------|------------|------------------------------|
|image                        |references  |null:false                    |
|name                         |string      |null:false                    |
|info                         |text        |null:false                    |
|category_select              |references  |null:false, foreign_key:true  |
|sales_status_select          |references  |null:false, foreign_key:true  |
|shipping_fee_status_select   |references  |null:false, foreign_key:true  |
|prefecture_select            |references  |null:false, foreign_key:true  |
|schduled_delivery_select     |references  |null:false, foreign_key:true  |
|price                        |integer     |null:false                    |
|price_fee                    |references  |-                             |
|sales_profit                 |references  |-                             |


##  item_purchases テーブル

| Column        |Type           |Options                         |
|               |               |                                |
|user_id        |references     |null:false, foreign_key:true    |
|item_id        |references     |null:false, foreign_key:true    |



##  address テーブル

|Column                 |type        |Option           |
|-----------------------|------------|-----------------|
|post_code              |string      |null:false       |
|prefecture_select      |string      |null:false       |
|city                   |string      |null:false       |
|municipality           |string      |null:false       |
|building_name          |string      |-                |
|phone_number           |string      |null:false       |



