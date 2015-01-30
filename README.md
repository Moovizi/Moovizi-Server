# Moovizi API

- Setup project
  - Navitia API key
  - Getting data
- Documentation

## Setup project

Here are few simple steps to setup the project and get data to start working on it.

#### Navitia API key

Few steps to run the project:
- Get your own Navitia API key: http://navitia.io
- Set a `NAVITIA_KEY` environment variable with the Navitia API key as value

The project is now setup and ready to run.

#### Getting data

You can then get all stations available from Navitia API using our `GET /stations/get` API method.

**Note that this is a very long process, between 5-10 minutes!**

## Documentation

`Stations`
<table>
  <thead>
    <tr>
      <th>Description</th>
      <th>HTTP</th>
      <th>URL</th>
      <th>Parameters</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Get all stations from Navitia API</td>
      <td>GET</td>
      <td>/stations/get</td>
      <td>-</td>
    </tr>
  </tbody>
</table>

`Issues`
<table>
  <thead>
    <tr>
      <th>Description</th>
      <th>HTTP</th>
      <th>URL</th>
      <th>Parameters</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Show an issue</td>
      <td>GET</td>
      <td>/issues/:id</td>
      <td>-</td>
    </tr>
    <tr>
      <td>Show issues around coordinates</td>
      <td>GET</td>
      <td>/issues/around</td>
      <td>
        <ul>
          <li>latitude (float)</li>
          <li>longitude (float)</li>
          <li>radius (integer)</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Create an issue</td>
      <td>POST</td>
      <td>/issues</td>
      <td>
        <ul>
          <li>latitude (float)</li>
          <li>longitude (float)</li>
          <li>description (string)</li>
          <li>photo (file) - <b>optional</b></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Update an issue</td>
      <td>PUT</td>
      <td>/issues/:id</td>
      <td>
        <ul>
          <li>latitude (float) - <b>optional</b></li>
          <li>longitude (float) - <b>optional</b></li>
          <li>description (string) - <b>optional</b></li>
          <li>photo (file) - <b>optional</b></li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>
