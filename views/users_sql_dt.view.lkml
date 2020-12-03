view: users_sql_dt {
  derived_table: {
    sql: select u.id, ${users.state_case} as state_case
    from demo_db.users u
    left join ${users.SQL_TABLE_NAME} v on u.id = v.id ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: state_case {
    type:  string
    sql: ${TABLE}.state_case ;;
  }

}
