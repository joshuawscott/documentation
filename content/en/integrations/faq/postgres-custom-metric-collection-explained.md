---
title: Postgres Custom Metric Collection
kind: faq
disable_toc: true
further_reading:
- link: "integrations/postgres/"
  tag: "Documentation"
  text: "Postgres Integration"
---

To collect custom metrics with the Postgres integration, use the `custom_queries` option in the `conf.d/postgres.d/conf.yaml` file at the root of your [Agent's configuration directory][1]. See the sample [postgres.d/conf.yaml][2] for more details.

## Configuration

`custom_queries` has the following options:

| Option        | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|---------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| metric_prefix | Yes      | Each metric starts with the chosen prefix.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| query         | Yes      | This is the SQL to execute. It can be a simple statement or a multi-line script. All of the rows of the results are evaluated. Use the pipe if you require a multi-line script.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| columns       | Yes      | This is a list representing each column ordered sequentially from left to right. The number of columns must equal the number of columns returned in the query. There are 2 required pieces of data:<br>- `name`: This is the suffix to append to the metric_prefix to form the full metric name. If the `type` is specified as `tag`, the column is instead applied as a tag to every metric collected by this query.<br>- `type`: This is the submission method (gauge, count, rate, etc.). This can also be set to 'tag' to tag each metric in the row with the name and value of the item in this column. |
| tags          | No       | A list of tags to apply to each metric (as specified above).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

## Example

### Database and table

Below is the `company` table from `testdb` database. The table contains 3 employee records:

```
testdb=# SELECT * FROM company;

id| name  | age| address    |salary | entry_date | last_raise_time
-------------------------------------------------------------------
1 | Paul  | 32 | California | 20000 | 1457570000 | 1457570300
2 | Allen | 25 | Texas      | 30000 | 1457570060 | 1457570300
3 | Teddy | 23 | Norway     | 45000 | 1457570120 | 1457570300
```

### From a SQL query to the YAML configuration

The goal is to capture the age and salary of Paul as metric values with his name and address as tags.

SQL query:
```
SELECT age,salary,name,address FROM company WHERE name = 'Paul'
```

Corresponding `custom_queries` YAML configuration:

```
custom_queries:
  - metric_prefix: postgresql
    query: SELECT age,salary,name,address FROM company WHERE name = 'Paul'
    columns:
      - name: employee_age
        type: gauge
      - name: employee_salary
        type: gauge
      - name: name
        type: tag
      - name: localisation
        type: tag
    tags:
      - query:custom
```

After updating the Postgres YAML file, [restart the Datadog Agent][3].

### Validation

To verify the result, search for the metrics using the [Metrics Explorer][4]:

{{< img src="integrations/faq/sql_metric_explorer.png" alt="sql_metric_explorer" responsive="true" >}}

### Debugging

[Run the Agent's status subcommand][5] and look for `postgres` under the Checks section:

```
postgres
--------
  - instance #0 [ERROR]: 'Missing metric_prefix parameter in custom_queries'
  - Collected 0 metrics, 0 events & 0 service checks
```

Additionally, the [Agent's logs][6] may provide useful information.

## Further Reading

{{< partial name="whats-next/whats-next.html" >}}

[1]: /agent/guide/agent-configuration-files/#agent-configuration-directory
[2]: https://github.com/DataDog/integrations-core/blob/master/postgres/datadog_checks/postgres/data/conf.yaml.example
[3]: /agent/guide/agent-commands/?tab=agentv6#restart-the-agent
[4]: /graphing/metrics/explorer
[5]: /agent/guide/agent-commands/#agent-status-and-information
[6]: /agent/guide/agent-log-files
