connection: "thelook_bq"

# include all the views
include: "/views/**/*.view"

datagroup: thelook_bq_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: thelook_bq_default_datagroup


explore: billion_orders_wide {
  join: orders {
    type: left_outer
    sql_on: ${billion_orders_wide.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: billion_orders {
  join: orders {
    type: left_outer
    sql_on: ${billion_orders.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: all_types {}

explore: asdftest {}

explore: connection_reg_r3 {}

explore: erin_newtable {}


explore: hundred_million_orders_wide {
  join: orders {
    type: left_outer
    sql_on: ${hundred_million_orders_wide.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: hundred_million_orders {
  join: orders {
    type: left_outer
    sql_on: ${hundred_million_orders.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


explore: nested_and_repeated {
  join: nested_and_repeated__repeated_field {
    view_label: "Nested And Repeated: Repeated Field"
    sql: LEFT JOIN UNNEST(${nested_and_repeated.repeated_field}) as nested_and_repeated__repeated_field ;;
    relationship: one_to_many
  }

  join: nested_and_repeated__doubly_nested_and_repeated {
    view_label: "Nested And Repeated: Doubly Nested And Repeated"
    sql: LEFT JOIN UNNEST(${nested_and_repeated.doubly_nested_and_repeated}) as nested_and_repeated__doubly_nested_and_repeated ;;
    relationship: one_to_many
  }

  join: nested_and_repeated__doubly_nested_and_repeated__inner_repeated {
    view_label: "Nested And Repeated: Doubly Nested And Repeated Inner Repeated"
    sql: LEFT JOIN UNNEST(${nested_and_repeated__doubly_nested_and_repeated.inner_repeated}) as nested_and_repeated__doubly_nested_and_repeated__inner_repeated ;;
    relationship: one_to_many
  }
}

explore: orders_base_copy {
  join: users {
    type: left_outer
    sql_on: ${orders_base_copy.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}


explore: orders_date_string {
  join: users {
    type: left_outer
    sql_on: ${orders_date_string.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_date_string_test2 {
  join: users {
    type: left_outer
    sql_on: ${orders_date_string_test2.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}



explore: testing_table {}

explore: swett_del {}

explore: testing_table_one {}

explore: testme {}


explore: users {}
