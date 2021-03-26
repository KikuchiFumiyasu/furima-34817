## DB設計

## users table

| Column                 | Type   | Options     |
| ---------------------- | ------ | ----------- |
| nickname               | string | null: false |
| email                  | string | null: false |
| encrypted_password     | string | null: false |
| last_name              | string | null: false |
| last_name_how_to_read  | string | null: false |
| first_name             | string | null: false |
| first_name_how_to_read | string | null: false |
| birth_day              | string | null: false |

### Association
* has_many :items
* belongs_to :client


## items テーブル

| Column                 | Type    | Options                        |
| ---------------------- | ------- | ------------------------------ |
| image                  | string  | null: false                    |
| item_name              | string  | null: false                    |
| item_description       | string  | null: false                    |
| category               | string  | null: false                    |
| item_status            | string  | null: false                    |
| shipping_charge_burden | string  | null: false                    |
| shipping_area          | string  | null: false                    |
| shipping_period        | string  | null: false                    |
| price                  | string  | null: false                    |
| user_id                | integer | null: false, foreign_key: true |

### Association
 - belongs_to :user


## client テーブル

| Column                 | Type    | Options                        |
| ---------------------- | ------- | ------------------------------ |
| last_name              | string  | null: false                    |
| last_name_how_to_read  | string  | null: false                    |
| first_name             | string  | null: false                    |
| first_name_how_to_read | string  | null: false                    |
| post_code              | string  | null: false                    |
| prefectures            | string  | null: false                    |
| city                   | string  | null: false                    |
| address                | string  | null: false                    |
| building_name          | string  |                                |
| phone_number           | string  | null: false                    |
| user_id                | integer | null: false, foreign_key: true |

### Association
- belongs_to :user


<!-- ##フリマアプリ

users テーブル
・nickname(ニックネーム)
・email(Eメール)
・encrypted_password(パスワード)
・last_name(名字)
・last_name_how_to_read(名字フリガナ)
・first_name(名前)
・first_name_how_to_read(名前フリガナ)
・birth_day(生年月日)


items テーブル
・image(商品画像)
・item_name(商品名)
・item_description(商品説明
・category(カテゴリー)
・item_status(商品の状態)
・shipping_charge_burden(配送料負担)
・shipping_area(発送元の地域)
・shipping_period(発送までの日数)
・price
・user_id


comments テーブル
・text
・user_id
・item_id


client テーブル
・last_name(名字)
・last_name_how_to_read(名字フリガナ)
・first_name(名前)
・first_name_how_to_read(名前フリガナ)
・post_code
・prefectures(都道府県)
・city(市)
・address(住所)
・user_id -->
