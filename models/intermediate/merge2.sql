{{ config(materialized = 'table') }}


select *
from {{ ref('merge1') }}
