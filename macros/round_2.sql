{% macro round_2(column) %}
    ROUND(CAST({{ column }} AS NUMERIC),2)
{% endmacro %}