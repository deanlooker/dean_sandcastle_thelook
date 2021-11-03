view: create_bigint_test {
  derived_table: {
 sql:
    SELECT CAST(CONV(id,16,10) AS SIGNED INTEGER) as bigint_id, orders.*
    from demo_db.orders;;

    sql_trigger_value: 1 ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: bigint_id {
    type: number
    sql: ${TABLE}.bigint_id ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {}
 }
