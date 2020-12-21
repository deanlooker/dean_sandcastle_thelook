view: test_lookup_new {
  derived_table: {
    sql: SELECT order_id as loan, inventory_item_id as promotion
      FROM demo_db.order_items
      WHERE order_id >= 10 and order_id <=19
      order by 1 asc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: loan {
    type: number
    sql: ${TABLE}.loan ;;
  }

  dimension: promotion {
    type: number
    sql: ${TABLE}.promotion ;;
  }

  set: detail {
    fields: [loan, promotion]
  }

  measure: promotion_list {
    type: list
    list_field: promotion
  }
}
