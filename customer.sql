{% snapshot customer_snapshot}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/address",
        target_schema = 'snapshots',
        invalidate_hard_deletes = TRUE,
        unique_key = 'CustomerID',
        strategy='check',
        check_cols = 'all'
        )

}}

with source_data as (
    select
        CustomerID,
        NameStyle,
        Title,
        FirstName,
        MiddleName,
        LastName,
        Suffix,
        CompanyName,
        SalesPerson,
        EmailAddress,
        Phone,
        PasswordHash,
        PasswordSalt
    from {{source('saleslt', 'customer')}}
)
select *
from source_data

{% endsnapshot %}