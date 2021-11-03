project_name: "dean_thelook"



constant: connection {
  value: "thelook"
}
constant: sql_code {
  value: "SELECT
        * from demo_db.orders
        where {% condition filter_test %} status {% endcondition %}
      order by created_at desc"
}

local_dependency: {
  project: "phish_thesis"
}
