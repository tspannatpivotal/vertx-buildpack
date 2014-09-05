# Vertx Container
The Vertx Container allows [Vertx][r] modules to be deployed. You will need to setup a module with a mod.json file and push its contents using this buildpack.

<table>
  <tr>
    <td><strong>Detection Criteria</strong></td>
    <td>A valid mod.json file located on your directory</td>
  </tr>
  <tr>
    <td><strong>Tags</strong></td>
    <td><tt>vertx=&lt;version&gt;</tt></td>
  </tr>
</table>
Tags are printed to standard output by the buildpack detect script

There's no support for HA or distributed EventBus at the moment. Since [Hazelcast][h] uses multicast for its P2P discovery, its going to be tricky to get this working.

The buildpack expect either a zipfile with the mod.json or an exploded directory. Internally the buildpack will deploy it as a zip and use vertx runzip <ZIPFILE>. The generated ZIPFILE is named after <application_name>-1.0.0.zip. 

## Configuration
The Vertx Container cannot be configured.

[r]: http://www.vertx.io
[h]: http://www.hazelcast.org
