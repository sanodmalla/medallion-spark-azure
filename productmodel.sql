{% snapshot productmodel_snapshot}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/address",
        target_schema = 'snapshots',
        invalidate_hard_deletes = TRUE,
        unique_key = 'ProductModelID',
        strategy='check',
        check_cols = 'all'
        )

}}

with source_data as (
    select
        ProductModelID,
        Name,
        CatalogDescription
    from {{source('saleslt', 'productmodel')}}
)
select *
from source_data

{% endsnapshot %}