{%- macro get_aggregate_events() -%}

{%- set event_types = dbt_utils.get_query_results_as_dict(
    "select DISTINCT event_type from" ~ ref('stg_greenery_events')) -%}
        {% for event_type in event_types['event_type'] -%}
        sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}
        {%- if not loop.last -%}
            , 
        {%- endif %} 
        {% endfor -%}
  
{%- endmacro -%}

