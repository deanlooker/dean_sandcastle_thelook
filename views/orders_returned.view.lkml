view: orders_returned {
  derived_table: {
    sql: SELECT
        order_items.order_id  AS `order_id`,
        max(order_items.returned_at) AS `returned_at`,
        max(order_items.id) as `max_order_item_id`
      FROM demo_db.order_items  AS order_items
      group by 1
      order by 2 desc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned_at {
    type: time
    sql: ${TABLE}.returned_at ;;
  }

  dimension: is_returned {
    type:  yesno
    sql: ${returned_at_time} is not null ;;
  }

  dimension: max_order_item_id {
    type: number
    sql: ${TABLE}.max_order_item_id ;;
  }

  set: detail {
    fields: [order_id, returned_at_time]
  }
}
