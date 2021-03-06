view: pdttest {

  derived_table: {
    sql: SELECT
        * from demo_db.users
      FROM orders
      GROUP BY user_id
      ;;
      indexes: ["id"]
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
}

explore: pdttest {}
