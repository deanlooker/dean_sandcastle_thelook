view: test_create_process {

derived_table: {
  create_process: {
    sql_step:
      -- create base fact transaction data
        CREATE TABLE ${SQL_TABLE_NAME}
          SELECT
            orders.order_id as new_order_id, orders.created_at as new_created_at, sum(order_items.sale_price) as total_price
          from demo_db.order_items order_items
            inner join ${orders_pdt_test.SQL_TABLE_NAME} orders ON order_items.order_id = orders.id
      ;;
    sql_step:
        -- ADD INDEXES to table
        ALTER TABLE ${SQL_TABLE_NAME} ADD PRIMARY KEY(new_order_id);;

      sql_step:
          CREATE INDEX idx_created_at ON ${SQL_TABLE_NAME} (new_created_at);;
    }
    datagroup_trigger: dean_test_default_datagroup
    #sql_trigger_value: SELECT FLOOR((UNIX_TIMESTAMP(NOW()) - 60*60*0 - 30*60 )/(60*60*24))    ;;
  }
   }
