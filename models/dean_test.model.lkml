connection: "thelook"

# include all the views
include: "/views/**/*.view"

datagroup: dean_test_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dean_test_default_datagroup

explore: connection_reg_r3 {
  sql_always_where: 1=2 ;;
}

explore: derived_test_table_3_20190510 {}

# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

# explore: order_items_ext {
#   hidden:  no
#   extends: [order_items]
# }

explore: order_items {
#   hidden:  yes
  access_filter: {
    field: users.state
    user_attribute: state
  }
  view_name: order_items
  join: dean_orders_2 {
    type: left_outer
    sql_on: ${order_items.order_id} = ${dean_orders_2.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${dean_orders_2.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    type: left_outer
    sql_on: ${users.id} = ${user_facts.id} ;;
    relationship: many_to_one
  }
}

# explore: order_items_users {
#   extends: [order_items]
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }

#   join: user_facts {
#     type: left_outer
#     sql_on: ${user_facts.id} = ${users.id} ;;
#     relationship: one_to_one
#   }
#   join: products {
#     fields: []
#   }
# }

explore: dean_orders_2 {
  sql_always_where:
 ${created_date} >= {% date_start dean_orders_2.date_filter %} AND ${created_date} <= {% date_end dean_orders_2.date_filter %} AND ${created_date} > date_sub({% date_end dean_orders_2.date_filter %}, INTERVAL 365 DAY) ;;



  join: users {
    type: left_outer
    sql_on: ${dean_orders_2.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: order_items {
    type: inner
    sql_on: ${order_items.order_id} = ${dean_orders_2.id} ;;
    relationship: one_to_many
  }
}

explore: products {}

explore: dean_orders {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  join: user_facts {
    type: left_outer
    sql_on: ${user_facts.id} = ${users.id} ;;
    relationship: one_to_one
  }
}

explore: users_nn {}
