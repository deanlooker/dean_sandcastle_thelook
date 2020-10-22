view: products_brand_count {
  derived_table: {
    sql: SELECT brand, count(*) as brand_count
      FROM products
      group by 1
      order by 2 desc
       ;;
  }


  dimension: brand {
    type: string
    primary_key: yes
    sql: ${TABLE}.brand ;;
  }

  dimension: brand_count {
    type: number
    sql: ${TABLE}.brand_count ;;
  }


  set: detail {
    fields: [brand, brand_count]
  }
}
