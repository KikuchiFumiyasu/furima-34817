## DB設計

## users table

| Column                 | Type   | Options                   |
| ---------------------- | ------ | ------------------------- |
| nickname               | string | null: false               |
| email                  | string | null: false, unique: true |
| encrypted_password     | string | null: false               |
| last_name              | string | null: false               |
| last_name_how_to_read  | string | null: false               |
| first_name             | string | null: false               |
| first_name_how_to_read | string | null: false               |
| birth_day              | date   | null: false               |

### Association
* has_many :items
* has_many :purchases
* has_many :comments


## items table

| Column                    | Type       | Options                        |
| ------------------------- | ---------- | ------------------------------ |
| name                      | string     | null: false                    |
| description               | text       | null: false                    |
| category_id               | integer    | null: false                    |
| status_id                 | integer    | null: false                    |
| shipping_charge_burden_id | integer    | null: false                    |
| shipping_area_id          | integer    | null: false                    |
| shipping_period_id        | integer    | null: false                    |
| price                     | integer    | null: false                    |
| user                      | references | null: false, foreign_key: true |

### Association
 - belongs_to :user
 - has_one :purchase


## addresses table

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| shipping_area_id | integer    | null: false                    |
| city             | string     | null: false                    |
| address          | string     | null: false                    |
| building_name    | string     |                                |
| phone_number     | string     | null: false                    |
| purchase         | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase


## purchases table

| Column  | Type       | Options                        |
| ------  | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- has_one :address


## comments table

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true | 
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

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
・image(商品画像) active_storage
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


addresses テーブル
・post_code
・prefectures(都道府県)
・city(市)
・address(住所)
・user_id 

cade テーブル
・card_number
・expiration_date
・security_code

-->
