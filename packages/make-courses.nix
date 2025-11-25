{lib, fetchurl}:
{
  catalog,
  revision,
  hash
}:
fetchurl {
  urls = [
    "http://catalog-manage-dev.l:8080/api/course/short-courses/${catalog}?timestamp=${revision}"
    "https://dev.upravljanje-katalog.lpm.feri.um.si/api/course/short-courses/${catalog}?timestamp=${revision}"
    "http://catalog-manage.l:8080/api/course/short-courses/${catalog}?timestamp=${revision}"
    "https://upravljanje-katalog.lpm.feri.um.si/api/course/short-courses/${catalog}?timestamp=${revision}"
  ];
  inherit hash;
}
