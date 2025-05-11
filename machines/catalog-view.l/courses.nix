{lib, fetchurl}:
let
  catalog = "3b88bf36-eb8b-4c9f-bd29-545451665e87";
  revision = builtins.readFile ./revision;
in
fetchurl {
  urls = [
    "http://catalog-manage.l:8080/api/course/short-courses/${catalog}?timestamp=${revision}"
    "https://scms.catalog.lpm.rwx.si/api/course/short-courses/${catalog}?timestamp=${revision}"
  ];
  hash = "sha256-stBcMVbk+HcPp6jMPa7L6JkIIxRrEnfP6r2rPOQwMag=";
}
