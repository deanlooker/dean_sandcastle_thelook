- dashboard: bitcloud_field_test
  title: bitcloud field test
  layout: newspaper
  elements:
  - title: tile1
    name: tile1
    model: bitcloud2
    explore: orders
    type: table
    fields:
    - orders.id
    - orders.count
    - orders.status
    sorts:
    - orders.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    listen:
      created: orders.created_date
    row: 0
    col: 0
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: bitcloud2
    explore: orders
    type: looker_column
    fields:
    - orders.id
    - orders.count
    - orders.status
    sorts:
    - orders.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      created: orders.created_date
    row: 0
    col: 8
    width: 8
    height: 6
  filters:
  - name: created
    title: created
    type: field_filter
    default_value: 7 days
    allow_multiple_values: true
    required: false
    model: bitcloud2
    explore: orders
    field: orders.created_date
  - name: datetest
    type: date_filter
    explore: orders
