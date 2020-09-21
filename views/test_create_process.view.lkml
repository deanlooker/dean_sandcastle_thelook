# view: test_create_process {
#
#   derived_table: {
#     create_process: {
#       sql_step:
#                 SELECT user_id AS customer_id, COUNT(*) AS lifetime_orders
#                 FROM demo_db.orders
#                 GROUP BY customer_id ;;
#       }
#     }
#     dimension: customer_id {
#       type: string
#       sql: ${TABLE}.customer_id ;;
#     }
#     dimension: lifetime_orders {
#       type: number
#       sql: ${TABLE}.lifetime_orders ;;
#     }
#   }
