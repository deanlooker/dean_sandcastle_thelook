view: erin_newtable {
  sql_table_name: `looker_test.erin_newtable`
    ;;

  dimension: my_column {
    type: number
    description: "column description from BQ"
    sql: ${TABLE}.my_column ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
