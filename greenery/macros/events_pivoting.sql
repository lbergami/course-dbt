{%- macro events_pivoting() -%}

{%- set event_types = ['package_shipped', 'page_view', 'checkout', 'add_to_cart'] -%}
        {% for event_type in event_types -%}
        sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}
        {%- if not loop.last -%}
            , 
        {%- endif %} 
        {% endfor -%}
  
{%- endmacro -%}