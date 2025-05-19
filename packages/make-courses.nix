{lib, fetchurl}:
{
  catalog,
  revision,
  hash
}:
fetchurl {
  urls = [
    "http://catalog-manage.l:8080/api/course/short-courses/${catalog}?timestamp=${revision}"
    "https://scms.catalog.lpm.rwx.si/api/course/short-courses/${catalog}?timestamp=${revision}"
  ];
  inherit hash;
}
