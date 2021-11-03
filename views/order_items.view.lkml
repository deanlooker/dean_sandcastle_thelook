view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
    required_access_grants: [can_see_sensitive_data_only]
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }



  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  dimension: sale_price_negative {
    type: number
    sql: (-1 * ${TABLE}.sale_price) ;;
  }

  dimension: sale_price_both {
    type: number
    sql:  CASE WHEN ${users.state} = "New York" THEN ${sale_price_negative} ELSE ${sale_price} end ;;
  }

  measure: total_sale_price_with_negative {
    type: sum
    sql: ${sale_price_both} ;;
  }

  measure: total_sale_price_with_negative_formatted {
    type: number
    sql: CASE WHEN ${total_sale_price_with_negative} < 0 THEN 0 else ${total_sale_price_with_negative} end;;
    html: {{total_sale_price_with_negative._rendered_value}}  ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
