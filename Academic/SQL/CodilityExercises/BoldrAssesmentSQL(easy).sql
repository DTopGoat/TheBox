/**create table price_updates(
product varchar not null,
date date not null,
price int not null,
unique(product, date)
);

Create an SQL query which list all products whose price increased with every update.

*/



-- Implement your solution here
with cteCountProduct as (
SELECT prod1.product as product 
FROM price_updates Prod1, price_updates Prod2
where 
Prod1.product = Prod2.product
AND Prod1.date < Prod2.date
group by Prod1.product
HAVING MAX(prod1.price) < max(prod2.price)
)
select product from cteCountProduct

/**
works only with below assumed instances as per instruction;
    > product and date are unique
    > price are positive values 
**/