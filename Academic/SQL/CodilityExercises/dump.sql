/**Given a table events with the following structure:

  create table events (
      event_type integer not null,
      value integer not null,
      time timestamp not null,
      unique(event_type, time)
  );
write an SQL query that, for each event_type that has been registered more than once, returns the difference between the latest (i.e. the most recent in terms of time) and the second latest value. The table should be ordered by event_type (in ascending order).

For example, given the following data:

   event_type | value      | time
  ------------+------------+--------------------
   2          | 5          | 2015-05-09 12:42:00
   4          | -42        | 2015-05-09 13:19:57
   2          | 2          | 2015-05-09 14:48:30
   2          | 7          | 2015-05-09 12:54:39
   3          | 16         | 2015-05-09 13:19:57
   3          | 20         | 2015-05-09 15:01:09
your query should return the following rowset:

   event_type | value
  ------------+-----------
   2          | -5
   3          | 4
For the event_type 2, the latest value is 2 and the second latest value is 7, so the difference between them is −5.

The names of the columns in the rowset don't matter, but their order does.

Copyright 2009–2024 by Codility Limited. All Rights Reserved. Unauthorized copying, publication or disclosure prohibited.
**/

------------------------Implement your solution here ------------------


--100% score
with maxT as (
    select event_type, max(time) as time
    from events
    where event_type  IN 
    (
        select event_type
        from events
        group by event_type
        having count(event_type) > 1
    )
    group by event_type
),

Latestno as (
    select a.event_type, a.value as firstValue
    from events a, maxT b
    where a.event_type = b.event_type
    AND a.time = b.time

),
SecondT as (
    select a.event_type, max(a.time) as Stime
    from events a, maxT b
    where a.event_type = b.event_type
    AND a.time != b.time
    group by a.event_type

),
SecondNo as (
    select a.event_type, a.value as secondValue
    from events a, SecondT b
    where a.event_type = b.event_type
    AND a.time = b.Stime

)

select a.event_type, a.firstValue - b.secondValue as value
from Latestno a
inner join SecondNo b on b.event_type = a.event_type
order by a.event_type

create table price_updates(
    product varchar not null,
      time date not null,
      price int not null

);

Create and SQL query that which list all products whose price increased with every update.


-- Implement your solution here
with cteSelectProduct as (
select *
from price_updates
),
countProduct as (
Select a.product
from cteSelectProduct a, price_updates b
where (
a.product = b.product
and a.date < b.date 
)
group by a.product
having max(a.price) < max(b.price)
)

select * from countProduct


SELECT p1.product
FROM price_updates p1
JOIN price_updates p2
ON p1.product = p2.product AND p1.date < p2.date
GROUP BY p1.product
HAVING MAX(p1.price) < MAX(p2.price);



cteCountProduct as (

SELECT product 
FROM price_updates Prod1
JOIN price_updates Prod2 on Prod1.product = Prod2.product
AND Prod1.date < Prod2.date
group by Prod1.product
HAVING MAX(prod1.price) < max(prod2.price)

)



with cteCountProduct as (

SELECT prod1.product 
FROM price_updates Prod1
JOIN price_updates Prod2 on Prod1.product = Prod2.product
AND Prod1.date < Prod2.date
group by Prod1.product
HAVING MAX(prod1.price) < max(prod2.price)

)

select * from cteCountProduct




with cteCountProduct as (

SELECT prod1.product 
FROM price_updates Prod1, price_updates Prod2
where Prod1.product = Prod2.product
AND Prod1.date < Prod2.date
group by Prod1.product
HAVING MAX(prod1.price) < max(prod2.price)

)
select * from cteCountProduct




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

