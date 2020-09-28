view: test_create_process {

derived_table: {
  create_process: {
    sql_step:
      -- create base fact transaction data
        CREATE TABLE ${SQL_TABLE_NAME}
          SELECT
            o.order_id as order_id, o.created_at as created_at, sum(i.sale_price) as total_price
          from demo_db.order_items i
            inner join ${orders_pdt_test.SQL_TABLE_NAME} o ON i.order_id = o.id
      ;;
    sql_step:
        -- ADD INDEXES to table
        ALTER TABLE ${SQL_TABLE_NAME} ADD PRIMARY KEY(order_id);;

      sql_step:
          CREATE INDEX idx_created_at ON ${SQL_TABLE_NAME} (created_at);;
    }
    datagroup_trigger: dean_test_default_datagroup
    #sql_trigger_value: SELECT FLOOR((UNIX_TIMESTAMP(NOW()) - 60*60*0 - 30*60 )/(60*60*24))    ;;
  }
   }
