# Two Tables (Many-to-Many) Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item. **** INSERT ****

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order. *** INSERT ****
```

```
Nouns:

items, name, unit_price, quantity
orders, customer_name, order_items, date_of_order

```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | item_name, price, qty
| orders                | customer_name, date_of_order

1. Name of the first table (always plural): `items` 

    Column names: `item_name`, `price`, `qty`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date_of_order`

## 3. Decide the column types.
```
# EXAMPLE:

Table: items
id: SERIAL
name: text
price: int
qty: int

Table: orders
id: SERIAL
customer: text
date_of_order: date
```

## 4. Design the Many-to-Many relationship

item can be in many orders: yes
orders can contain many items: yes

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `items_orders`.

```
# EXAMPLE

Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 4. Write the SQL.

```sql
-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  qty int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date_of_order date
);

-- Create the join table.
CREATE TABLE items_tags (
  item_id int,
  order_id int,
  constraint fk_post foreign key(item_id) references items(id) on delete cascade,
  constraint fk_tag foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < posts_tags.sql
```