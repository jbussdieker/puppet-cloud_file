# Cloud File Module

[![Build Status](https://travis-ci.org/jbussdieker/puppet-cloud_file.png?branch=master)](https://travis-ci.org/jbussdieker/puppet-cloud_file)

This module manages files hosted on cloud providers. Currently only S3 is supported.

http://forge.puppetlabs.com/jbussdieker/cloud_file

## Parameters

* `ensure`: `present`, `absent`, `latest`. default: `present`.
* `path`: The local path for the destination file.
* `source`: Specify the source url of the cloud file ex (bucket_name/path/to/file).
* `access_key_id`: The AWS access key to connect to S3. (optional)
* `secret_access_key`: The AWS secret access key to connect to S3. (optional)

If `access_key_id` and `secret_access_key` are left blank, the credentials will attempt to be retrieved via the methods outlined [aws-sdk docs](http://docs.aws.amazon.com/AWSSdkDocsRuby/latest/DeveloperGuide/ruby-dg-setup.html#set-up-creds).

## Usage

    cloud_file {'/tmp/file':
      ensure            => present,
      source            => 'some_bucket/path/to/file',
      access_key_id     => '',
      secret_access_key => '',
    }
