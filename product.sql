{% snapshot product_snapshot}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/address",
        target_schema = 'snapshots',
        invalidate_hard_deletes = TRUE,
        unique_key = 'ProductID',
        strategy='check',
        check_cols = 'all'
        )

}}

with source_data as (
    select
        ProductID,
        Name,
        ProductionNumber,
        Color,
        StandardCost,
        ListPrice,
        Size,
        Weight,
        ProductCategoryID,
        ProductModelID,
        SellStartDate,
        SellEndDate,
        DiscontinuedDate,
        ThumbNailPhoto,
        ThumbnailPhotoFileName
    from {{source('saleslt', 'Product')}}
)
select *
from source_data

{% endsnapshot %}