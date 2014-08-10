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

__Please note:__ _This module requires the `aws-sdk` gem to be installed prior to use._

## Usage

    file { '/opt/scripts':
      ensure => directory,
      owner  => root,
      group  => root
    }

    cloud_file {'/opt/scripts/script.sh':
      ensure            => present,
      source            => 'bucket/path/to/script.sh',
      access_key_id     => 'EXAMPLE_ACCESS_KEY_ID',
      secret_access_key => 'EXAMPLE_SECRET_ACCESS_KEY',
    }

    # If you omit the access_key_id and secret_access_key, the S3 client will
    # attempt to authenticate automatically by one of the methods described
    # here: http://docs.aws.amazon.com/AWSSdkDocsRuby/latest/DeveloperGuide/prog-basics-creds.html
