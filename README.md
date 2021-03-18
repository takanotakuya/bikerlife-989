# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| self_introduction  | text   |                           |
| image              | string |                           |

### Association

- has_many :posts
- has_many :comments
- has_many :likes
- has_many :consultations
- has_many :consultations_comments

## posts テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| name      | string     | null: false                    |
| post_text | text       |                                |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :comments
- has_many :likes

## comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| comment_text | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| post         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## likes テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| post         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post


## consultations テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| name      | string     | null: false                    |
| post_text | text       | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :consultations_comments

## consultations_comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| comment_text | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| consultation | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :consultation
