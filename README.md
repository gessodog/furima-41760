#テーブル設計

## users テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| nickname           | string     | null: false                    |
| first_name         | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| birthday_year_id   | date       | null: false                    |
| birthday_month_id  | date       | null: false                    |
| birthday_day_id    | date       | null: false                    |

### Association

- has_many :items
- has_many :cards



## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item             | string     | null: false                    |
| item_information | text       | null: false                    |
| item_category_id | integer    | null: false                    |
| item_state_id    | integer    | null: false                    |
| delivery_cost_id | integer    | null: false                    |
| delivery_from_id | integer    | null: false                    |
| delivery_days_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :card



## cards テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| card_information  | integer    | null: false                    |
| card_deadline     | string     | null: false                    |
| card_securitycode | integer    | null: false                    |
| zipcode           | string     | null: false                    |
| prefecture_id     | integer    | null: false                    |
| city              | string     | null: false                    |
| house_number      | string     | null: false                    |
| building          | string     | null: false                    |
| telephone_number  | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |
| item              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item