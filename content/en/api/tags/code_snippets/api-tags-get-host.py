from datadog import initialize, api

options = {
    'api_key': '<YOUR_API_KEY>',
    'app_key': '<YOUR_APP_KEY>'
}

initialize(**options)

# Get tags by host id.
hosts = api.Hosts.search(q='hosts:')
print api.Tag.get(hosts['host_list'][0])
