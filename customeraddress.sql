{% snapshot customeraddress_snapshot}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/address",
        target_schema = 'snapshots',
        invalidate_hard_deletes = TRUE,
        unique_key = "CustomerID||'-'||AddressID",
        strategy='check',
        check_cols = 'all'
        )

}}

with source_data as (
    select
        CustomerID,
        AddressID,
        AddressType
    from {{source('saleslt', 'customeraddress')}}
)
select *
from source_data

{% endsnapshot %}