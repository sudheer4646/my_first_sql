cache_practice.sql
select count(*) from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

-- min,max and count information of tables will be cached in metadata and will help when you query that info
select min(I_WHOLESALE_COST),max(I_WHOLESALE_COST) from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";
select sum(I_WHOLESALE_COST) from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";
select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."CUSTOMER";

-- first run
select INV_ITEM_SK  from  "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."INVENTORY";

-- 2nd run it will get data from result cache
select INV_ITEM_SK  from  "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."INVENTORY";

-- if you give alias/add new field first it will get data from warehouse cache or remote disk
select INV_ITEM_SK as SK  from  "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."INVENTORY";


-- 2nd time if same query is run it will get results from result cache
select INV_ITEM_SK as SK  from  "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."INVENTORY";

select INV_ITEM_SK as INV_SK2 from  "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."INVENTORY";

select I_ITEM_ID from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM" where I_ITEM_ID=767868; 

/*next run onwards it will be give results from result cache untill there is any change in underlying data
or if the query is not used by any user in the last 24 hours */
-- 2nd run
select I_ITEM_ID from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

-- 3rd run
select I_ITEM_ID from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

-- If we rerun the query by giving alias to the field it will get details from local disk/SSD cache
select I_ITEM_ID as ID from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

-- next time onwards if we rerun the same query then it will get records from result cache
select I_ITEM_ID as ID from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

-- Result cache will be reused only if excat same query is reran

--it will never reuse result cache since current_timestamp is used in query and every time current_timestamp value will change

select I_ITEM_ID, current_timestamp from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM"; 

-- suspend warehouse with command or with UI as well
alter warehouse COMPUTE_WH suspend;

select I_ITEM_ID from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

--change the query it will go to remote disk again

select I_ITEM_ID,I_CURRENT_PRICE from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";


select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";


Disabling Result cache 
alter session set use_cached_result = true;

-- If we disable result cache it will never get data from result cache
select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";

alter warehouse COMPUTE_WH suspend;

select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."ITEM";  -- it will again get data from remote disk(centralized storage)