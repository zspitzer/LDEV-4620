# LDEV-4620

trying to repo https://luceeserver.atlassian.net/browse/LDEV-4620

IT'S REALLY ODD

works with script runner with 6.0.0.503

works with commandbox 6.0.0.492

fails with commandbox 6.0.0.503

the only thing which works with 503, is setting a password.txt and calling checkpassword, which then
reloads the config

micha even added a request blocker on startup, but that didn't help

added a sleep which didn't help

even adding a redirect in box.json to index.cfm didn't help, i.e. on a second request.

strange indeed