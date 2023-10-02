select 
    sum(case when status = 'success' then amount end) as total_revenue
from {{ ref('stg_payments') }}