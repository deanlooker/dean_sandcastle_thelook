connection: "thelook"

###testing lalalal ####
# include all the views
include: "/views/**/*.view"
include: "/dashboards/*"

## adding testing line ###

datagroup: dean_test_default_datagroup {
   sql_trigger: SELECT HOUR(CURTIME());;
  max_cache_age: "1 hour"
}

# persist_with: dean_test_default_datagroup

explore: connection_reg_r3 {
  sql_always_where: 1=2 ;;
}

explore: test_create_process {}

explore: derived_test_table_3_20190510 {}

access_grant: can_see_sensitive_data_only {
  user_attribute: can_see_sensitive_data
  allowed_values: ["yes"]
}

access_grant: can_see_any_data {
  user_attribute: can_see_sensitive_data
  allowed_values: ["yes","no"]
}

# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

explore: inventory_items {
  view_name: inventory_items
  required_access_grants: [can_see_sensitive_data_only]
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items_ext {
  label: "Inventory Items Extended"
  extends: [inventory_items]
  required_access_grants: [can_see_any_data]
}

# explore: users_sql_dt {}

explore: limited_orders {
  view_name: dean_orders_2
  always_filter: {filters: [user_id_parameter: ""]}
  sql_always_where: ${dean_orders_2.user_id} = {% parameter dean_orders_2.user_id_parameter %} ;;
  fields: [ALL_FIELDS*, -dean_orders_2.distinct_items ]
}

explore: limited_orders_suggest {
  from: dean_orders_2
  hidden: yes
  fields: [ALL_FIELDS*, -limited_orders_suggest.distinct_items ]
}



# explore: order_items_ext {
#   hidden:  no
#   extends: [order_items]
# }

explore: order_items {
#   hidden:  yes
  # access_filter: {
  #   field: users.state
  #   user_attribute: state
  # }
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
##   sql_always_where:
## ${created_date} >= {% date_start dean_orders_2.date_filter %} AND ${created_date} <= {% date_end dean_orders_2.date_filter %} AND ${created_date} > date_sub({% date_end dean_orders_2.date_filter %}, INTERVAL 365 DAY)
## ;;



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

explore: products {
  join: products_brand_count {
    type: left_outer
    sql_on: ${products.brand} = ${products_brand_count.brand} ;;
    relationship: many_to_one
   }
}

explore: dean_orders {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: order_items_or_max_return {
  view_name: dean_orders_2
  join: orders_returned {
    type: left_outer
    sql_on: ${dean_orders_2.id} = ${orders_returned.order_id} ;;
    relationship: one_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${dean_orders_2.id} = ${order_items.order_id}
            AND
            (CASE WHEN (NOT ${orders_returned.is_returned}) OR (${orders_returned.is_returned} AND ${orders_returned.max_order_item_id} = ${order_items.id}) THEN 1 ELSE 0 END) = 1 ;;
    relationship: one_to_many
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

explore: orders_dt_test {}

# explore: test_create_process {}
