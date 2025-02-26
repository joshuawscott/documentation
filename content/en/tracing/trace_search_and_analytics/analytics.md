---
title: Trace Analytics
kind: documentation
description: "Analytics on your APM data at infinite cardinality"
aliases:
  - /tracing/trace_search_analytics/analytics
  - /tracing/analytics
  - /tracing/visualization/analytics
further_reading:
- link: "tracing/setup/"
  tag: "Documentation"
  text: "Learn how to setup APM tracing with your application"
- link: "tracing/visualization/services_list/"
  tag: "Documentation"
  text: "Discover the list of services reporting to Datadog"
- link: "tracing/visualization/service"
  tag: "Documentation"
  text: "Learn more about services in Datadog"
- link: "tracing/visualization/resource"
  tag: "Documentation"
  text: "Dive into your resource performance and traces"
- link: "tracing/visualization/trace"
  tag: "Documentation"
  text: "Understand how to read a Datadog Trace"
- link: "tracing/trace_search_and_analytics/search"
  tag: "Documentation"
  text: "Global search of all your traces with tags"
---

Switch between the Trace search and the Trace Analytics modes by clicking on the *Trace Mode* button:

{{< img src="tracing/trace_search_and_analytics/analytics/switch_analytics.png" alt="Switch analytics" responsive="true" style="width:40%;">}}

## Trace Analytics query

Use the query to control what's displayed in your Trace Analytic:

1. Choose the `Duration` metric or a [Facet][1] to analyze. Selecting the `Duration` metric lets you choose the aggregation function whereas [Facet][1] displays the unique count.

    {{< img src="tracing/trace_search_and_analytics/analytics/choose_measure_facet.png" alt="choose measure facet" responsive="true" style="width:50%;">}}

2. Select the aggregation function for the `Duration` metric:

    {{< img src="tracing/trace_search_and_analytics/analytics/agg_function.png" alt="aggregation function" responsive="true" style="width:50%;">}}

3. Use [Tag][2] or [Facet][1] to split your Analytic.

    {{< img src="tracing/trace_search_and_analytics/analytics/split_by.png" alt="split by" responsive="true" style="width:50%;">}}

4. Choose to display either the *X* **top** or **bottom** values according to the selected [Facet][1] or `Duration`.

    {{< img src="tracing/trace_search_and_analytics/analytics/top_bottom_button.png" alt="top bottom button" responsive="true" style="width:20%;">}}

5. Choose the Analytic Timesteps.
  Changing the global timeframe changes the list of available Timesteps values.

    {{< img src="tracing/trace_search_and_analytics/analytics/timesteps.png" alt="Timestep" responsive="true" style="width:30%;">}}

## Visualizations

Select a Trace Analytic visualization type using the Analytic selector:

{{< img src="tracing/trace_search_and_analytics/analytics/graph_selector.png" alt="Graph selector" responsive="true" style="width:30%;">}}

Available visualizations:

* [Timeseries](#timeseries)
* [Top List](#top-list)

### Timeseries

Visualize the evolution of the `Duration` metric (or a [Facet][1] unique count of values) over a selected time frame, and (optionally) split by an available [Facet][1].

The following timeseries Trace Analytic shows:
The evolution of the **pc99** **duration** by steps of **5min** for each **Service**

{{< img src="tracing/trace_search_and_analytics/analytics/timeserie_example.png" alt="timeserie example" responsive="true" style="width:90%;">}}

### Top List

Visualize the top values from a [Facet][1] according to their `Duration` (or a [Facet][1] unique count of values):

The following Top List Trace Analytic shows:
The top **pc99** **duration** of **Service**

{{< img src="tracing/trace_search_and_analytics/analytics/top_list_example.png" alt="top list example" responsive="true" style="width:90%;">}}

### Table

Visualize the top values from a [facet][1] according to a chosen [measure][2] (the first measure you choose in the list), and display the value of additional measures for elements appearing in this top. Update search query or drill through traces corresponding to either dimension.

The following Table Log Analytics shows:
The evolution of the **top 10 Services** according to their **Duration**, along with the average **Throughput** and over the last 15 minutes.

{{< img src="tracing/trace_search_and_analytics/analytics/trace_table_example.png" alt="top list example" responsive="true" style="width:90%;">}}

## Related Traces

Select or click on a section of the graph to either zoom in the graph or see the list of traces corresponding to your selection:

{{< img src="tracing/trace_search_and_analytics/analytics/view_traces.png" alt="view Traces" responsive="true" style="width:40%;">}}

## Export

{{< img src="tracing/trace_search_and_analytics/analytics/export_button.png" alt="Export your analytics button" responsive="true" style="width:40%;">}}

Export your Trace analytic:

* To create a new [APM monitor][3]:
    This feature is not available yet.
* To an existing [Timeboard][4]:
    This functionality is in beta, [contact the Datadog support team][5] to activate it for your organization.

## Traces in Dashboard

Export [Trace Analytics][6] from the Trace search or build them directly in your [Dashboard][7] alongside metrics and logs.

[Learn more about the timeseries widget][8]

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}

[1]: /tracing/trace_search_and_analytics/search/#facets
[2]: /tracing/trace_search_and_analytics/search/#measures
[3]: /monitors/monitor_types/apm
[4]: /graphing/dashboards/timeboard
[5]: /help
[6]: /graphing/widgets/timeseries
[7]: /graphing/dashboards
[8]: /graphing/widgets/timeseries
