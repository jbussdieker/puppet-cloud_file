# Cloud File Module

This module manages files hosted on cloud providers. Currently only S3 is supported.

http://forge.puppetlabs.com/jbussdieker/cloud_file

## Parameters

* source:
 Specify the source url of the cloud file.

* access_key_id:
 The AWS access key to connect to S3.

* secret_access_key:
 The AWS secret access key to connect to S3.

## Usage

`````
cloud_file {'/tmp/file':
  ensure            => present,
  source            => 'some_bucket/path/to/file',
  access_key_id     => '',
  secret_access_key => '',
}
`````
