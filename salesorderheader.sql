{% snapshot salesorderheader_snapshot}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/address",
        target_schema = 'snapshots',
        invalidate_hard_deletes = TRUE,
        unique_key = 'SalesOrderID',
        strategy='check',
        check_cols = 'all'
        )

}}

with source_data as (
    select
        SalesOrderID,
        RevisionNumber,
        OrderDate,
        DueDate,
        ShipDate,
        Status,
        OnlineOrderFlag,
        SalesOrderNumber,
        AccountNumber,
        CustomerID,
        ShipToAddressID,
        BillToAddressID,
        ShipMethod,
        CreditCardApprovalCode,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue,
        Comment
    from {{source('saleslt', 'salesorderheader')}}
)
select *
from source_data

{% endsnapshot %}