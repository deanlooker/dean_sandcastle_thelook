view: pdttest {

  derived_table: {
    sql: SELECT
        * from demo_db.users
      FROM orders
      GROUP BY user_id
      ;;
      sql_trigger_value: Select Getdate() ;;
      indexes: ["id"]
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
}

explore: pdttest {}
