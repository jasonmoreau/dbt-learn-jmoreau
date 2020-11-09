SELECT
    ORDERS.ORDER_ID,
    CUSTOMERS.CUSTOMER_ID,
    ORDERS.ORDER_DATE,
    SUM(PAYMENT.AMOUNT/100) AS AMOUNT
FROM {{ ref('stg_orders') }} ORDERS
INNER JOIN {{ ref('stg_customers') }} CUSTOMERS
    ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
INNER JOIN RAW.STRIPE.PAYMENT AS PAYMENT
    ON ORDERS.ORDER_ID = PAYMENT.ORDERID
WHERE PAYMENT.STATUS = 'success'
GROUP BY 1, 2, 3