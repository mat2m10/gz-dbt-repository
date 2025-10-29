{{ config(materialized = 'table') }}

-- minimal passthrough for your class; expand later if needed
select *
from {{ ref('01_merging') }}