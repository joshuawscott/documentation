---
title: Agent Log collection
kind: documentation
description: Use the Datadog Agent to collect your logs and send them to Datadog
further_reading:
- link: "agent/logs/advanced_log_collection/#filter-logs"
  tag: "Documentation"
  text: "Filter logs sent to Datadog"
- link: "agent/logs/advanced_log_collection/#scrub-sensitive-data-from-your-logs"
  tag: "Documentation"
  text: "Scrub sensitive data from your logs"
- link: "agent/logs/advanced_log_collection/#multi-line-aggregation"
  tag: "Documentation"
  text: "Multi-line log aggregation"
- link: "agent/logs/advanced_log_collection/#tail-directories-by-using-wildcards"
  tag: "Documentation"
  text: "Tail directories by using wildcards"
- link: "agent/logs/advanced_log_collection/#global-processing-rules"
  tag: "Documentation"
  text: "Global processing rules"
---

Log collection requires the Datadog Agent v6.0+. Older versions of the Agent do not include the `log collection` interface. If you are not using the Agent already, follow the [Agent installation instructions][1].

Collecting logs is **disabled** by default in the Datadog Agent. Enable log collection in the Agent's [main configuration file][4] (`datadog.yaml`):

```
logs_enabled: true
```

The Datadog Agent sends its logs to Datadog over TLS-encrypted TCP. This requires outbound communication over port `10516`.

**Note**: If you're using Kubernetes, make sure to [enable log collection in your DaemonSet setup][2]. If you're using Docker, [enable log collection for the containerized Agent][3].

## Enabling log collection from integrations

To collect logs for a given integration, uncomment the logs section in that integration's `conf.yaml` file and configure it for your environment.

<div class="alert alert-warning">
Consult the <a href="/integrations/#cat-log-collection">list of supported integrations</a>  that include out of the box log configurations.
</div>

If an integration does not support logs by default, use the custom log collection.

## Custom log collection

Datadog Agent v6 can collect logs and forward them to Datadog from files, the network (TCP or UDP), journald, and Windows channels:

1. Create a new `<CUSTOM_LOG_SOURCE>.d/` folder in the `conf.d/` directory at the root of your [Agent's configuration directory][4].
2. Create a new `conf.yaml` file in this new folder.
3. Add a custom log collection configuration group with the parameters below.
4. [Restart your Agent][5] to take into account this new configuration.
5. Run the [Agent's status subcommand][6] and look for `<CUSTOM_LOG_SOURCE>` under the Checks section.

Below are examples of custom log collection setup:

{{< tabs >}}
{{% tab "Tail existing files" %}}

To gather logs from your `<APP_NAME>` application stored in `<PATH_LOG_FILE>/<LOG_FILE_NAME>.log` create a `<APP_NAME>.d/conf.yaml` file at the root of your [Agent's configuration directory][1] with the following content:

```
logs:
  - type: file
    path: <PATH_LOG_FILE>/<LOG_FILE_NAME>.log
    service: <APP_NAME>
    source: custom
```

**Note**: When tailing files for logs, the Datadog Agent v6 for **Windows** requires the log files have UTF8 encoding.


[1]: /agent/guide/agent-configuration-files
{{% /tab %}}

{{% tab "Stream logs from TCP/UDP" %}}

To gather logs from your `<APP_NAME>` application that forwards its logs with TCP over port **10518**, create a `<APP_NAME>.d/conf.yaml` file at the root of your [Agent's configuration directory][1] with the following content:

```
logs:
  - type: tcp
    port: 10518
    service: <APP_NAME>
    source: <CUSTOM_SOURCE>
```

If you are using Serilog, `Serilog.Sinks.Network` is an option for connecting with UDP.

**Note**: The Agent supports raw string, JSON, and Syslog formatted logs. If you are sending logs in batch, use line break characters to separate your logs.

[1]: /agent/guide/agent-configuration-files
{{% /tab %}}
{{% tab "Stream logs from journald" %}}

To gather logs from journald, create a `journald.d/conf.yaml` file at the root of your [Agent's configuration directory][1] with the following content:

```yaml
logs:
  - type: journald
    path: /var/log/journal/
```

Refer to the [journald integration][2] documentation for more details regarding the setup for containerized environments and units filtering.

[1]: /agent/guide/agent-configuration-files
[2]: /integrations/journald
{{% /tab %}}
{{% tab "Windows Events" %}}

To send Windows events as logs to Datadog, add the channels to `conf.d/win32_event_log.d/conf.yaml` manually or use the Datadog Agent Manager.

To see your channel list, run the following command in a PowerShell:

```
Get-WinEvent -ListLog *
```

To see the most active channels, run the following command in a PowerShell:

```
Get-WinEvent -ListLog * | sort RecordCount -Descending
```

Then add the channels to your `win32_event_log.d/conf.yaml` configuration file:

```
logs:
  - type: windows_event
    channel_path: <CHANNEL_1>
    source: <CHANNEL_1>
    service: <SERVICE>
    sourcecategory: windowsevent

  - type: windows_event
    channel_path: <CHANNEL_2>
    source: <CHANNEL_2>
    service: <SERVICE>
    sourcecategory: windowsevent
```

Edit the `<CHANNEL_X>` parameters with the Windows channel name you want to collect events from.
Set the corresponding `source` parameter to the same channel name to benefit from the [integration automatic processing pipeline setup][1].

Finally, [restart the Agent][2].


[1]: /logs/processing/pipelines/#integration-pipelines
[2]: /agent/basic_agent_usage/windows
{{% /tab %}}
{{< /tabs >}}

List of all available parameters for log collection:

| Parameter        | Required | Description                                                                                                                                                                                                                                                                                                                                         |
|------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `type`           | Yes      | The type of log input source. Valid values are: `tcp`, `udp`, `file`, `windows_event`, `docker`, or `journald`.                                                                                                                                                                                                                             |
| `port`           | Yes      | If `type` is **tcp** or **udp**, set the port for listening to logs.                                                                                                                                                                                                                                                                                           |
| `path`           | Yes      | If `type` is **file** or **journald**, set the file path for gathering logs.                                                                                                                                                                                                                                                                        |
| `channel_path`   | Yes      | If `type` is **windows_event**, list the Windows event channels for collecting logs.                                                                                                                                                                                                                                                                 |
| `service`        | Yes      | The name of the service owning the log. If you instrumented your service with [Datadog APM][7], this must be the same service name.                                                                                                                                                                                                                    |
| `source`         | Yes      | The attribute that defines which integration is sending the logs. If the logs do not come from an existing integration, then this field may include a custom source name. However, it is recommended that you match this value to the namespace of any related [custom metrics][8] you are collecting, for example: `myapp` from `myapp.request.count`. |
| `include_units`  | No       | If `type` is **journald**, list of the specific journald units to include.                                                                                                                                                                                                                                                                              |
| `exclude_units`  | No       | If `type` is **journald**, list of the specific journald units to exclude.                                                                                                                                                                                                                                                                              |
| `sourcecategory` | No       | A multiple value attribute used to refine the source attribute, for example: `source:mongodb, sourcecategory:db_slow_logs`.                                                                                                                                                                                                                         |
| `tags`           | No       | A list of tags added to each log collected ([learn more about tagging][9]).                                                                                                                                                                                                                                                                                    |

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}


[1]: https://app.datadoghq.com/account/settings#agent
[2]: /agent/kubernetes/daemonset_setup/#log-collection
[3]: /agent/docker/log
[4]: /agent/guide/agent-configuration-files
[5]: /agent/guide/agent-commands/#start-stop-and-restart-the-agent
[6]: /agent/guide/agent-commands/#agent-status-and-information
[7]: /tracing
[8]: /developers/metrics/custom_metrics
[9]: /tagging
