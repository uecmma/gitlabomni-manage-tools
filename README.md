# GitLab Omnibus Management Tools [![Travis Status][travis-image]][travis-url]

## Installation

See [Installation Document](doc/Installation.md).

## Usage

See `gitlab-manage help`

### Notify for cron job

```bash
gitlab-manage notify-cronjob
```

This command notifies you if new version was available.

* Mail Task: mailing the new version notification

### Update

```bash
gitlab-manage update
```

Update gitlab omnibus package if new version was available.

[travis-image]: https://travis-ci.org/uecmma/gitlabomni-manage-tools.svg?branch=master
[travis-url]: https://travis-ci.org/uecmma/gitlabomni-manage-tools.svg?branch=master
