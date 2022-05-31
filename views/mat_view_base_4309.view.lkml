view: mat_view_base_4309 {
  sql_table_name: `looker_test.mat_view_base_4309`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: fav_string {
    type: string
    sql: ${TABLE}.fav_string ;;
  }

  dimension: is_working {
    type: yesno
    sql: ${TABLE}.is_working ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
