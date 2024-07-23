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
