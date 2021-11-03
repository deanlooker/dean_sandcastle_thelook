include: "orders_pdt_test.view.lkml"

view: orders_pdt_test_daily {
extends: [orders_pdt_test]



  derived_table: {
    datagroup_trigger: dean_test_default_datagroup_daily
  }


}
