view: user_facts {
  derived_table: {
    sql_trigger_value: SELECT HOUR(CURTIME()) ;;
    explore_source: order_items {
      column: id { field: users.id }
      column: count { field: dean_orders_2.count }
      column: distinct_items { field: dean_orders_2.distinct_items }
      column: most_recent { field: dean_orders_2.most_recent }
      column: email { field: users.email }
      column: city { field: users.city }
    }
    indexes: ["id"]
  }

  dimension: id {
    type: number
  }

  dimension: count {
    type: number
  }

  dimension: distinct_items {
    type: number
  }

  dimension: most_recent {
    type: number
  }

  dimension: email {}

  dimension: city {}

  dimension: deantest {
    type:  yesno
  }

}
