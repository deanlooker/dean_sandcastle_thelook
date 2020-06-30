view: orders_dt_test {
  derived_table: {
    sql: SELECT
        * from demo_db.orders
      order by created_at desc
      limit {% parameter limit_num %}
      ;;
      }
 parameter: limit_num {
   type: number
 }


}
