```SQL
  -- create table employees (
--   id uuid,
--   name varchar(12)
-- );

CREATE TABLE employess (
    id UUID DEFAULT gen_random_uuid(),
    name VARCHAR(12)
);

select * from employess;

insert into employess (name) values (
    'prasanth'
);

insert into employess values (
    'vennila'
);

select * from employess;
```
